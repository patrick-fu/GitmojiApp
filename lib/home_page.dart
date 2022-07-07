import 'dart:io';
import 'package:flutter/cupertino.dart' hide MenuItem;
import 'package:flutter/material.dart' hide MenuItem;
import 'package:gitmojiapp/models/gitmoji_data_model.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:gitmojiapp/settings_page.dart';
import 'package:gitmojiapp/utils/platform_util.dart';
import 'package:gitmojiapp/widgets/gitmoji_row.dart';
import 'package:gitmojiapp/widgets/gitmoji_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener, TrayListener {
  bool _isAlwaysOnTop = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    GitmojiPersistence().initialize().then((value) {
      GitmojiDataModel.getGitmojiData().then((value) {
        setState(() {
          context.read<GitmojiViewModel>().allGitmojis = value.gitmojis;
        });
      });
    });
    if (kIsMacOS || kIsLinux || kIsWindows) {
      windowManager.addListener(this);
      trayManager.addListener(this);
      setupWindow();
      setupTrayIcon();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (kIsMacOS || kIsLinux || kIsWindows) {
      windowManager.removeListener(this);
      trayManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DragToMoveArea(
            child: Text('GitmojiApp', style: TextStyle(fontSize: 16))),
        toolbarHeight: 40,
        leading: alwaysOnTopButton(context),
        actions: [settingsButton(context)],
      ),
      body: Consumer<GitmojiViewModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              GitmojiSearchBar(
                focusNode: _focusNode,
                searchTextController: _searchTextController,
              ),
              Expanded(
                child: ListView(children: [
                  for (int index = 0;
                      index < model.filteredGitmojis.length;
                      index++)
                    GitmojiRow(dataSource: model.filteredGitmojis[index])
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget alwaysOnTopButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationZ(
          _isAlwaysOnTop ? 0.8 : 0,
        ),
        child: Icon(
          _isAlwaysOnTop ? Icons.push_pin : Icons.push_pin_outlined,
          size: 20,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        setState(() {
          _isAlwaysOnTop = !_isAlwaysOnTop;
        });
        windowManager.setAlwaysOnTop(_isAlwaysOnTop);
      },
    );
  }

  Widget settingsButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          final model = Provider.of<GitmojiViewModel>(context, listen: false);
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListenableProvider.value(
                    value: model,
                    child: SettingsPage(onDismiss: () {
                      Navigator.of(context).pop();
                    }));
              });
        });
  }

  void setupWindow() {
    Size minSize = const Size(350, 450);
    windowManager.setMinimumSize(minSize);
    WindowOptions windowOptions = WindowOptions(
      size: minSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await Future.delayed(const Duration(milliseconds: 100));
      await _windowShow();
    });
  }

  void setupTrayIcon() async {
    String trayIconName = kIsWindows ? 'tray_icon.ico' : 'tray_icon.png';

    await trayManager.destroy();
    await trayManager.setIcon(
      'assets/$trayIconName',
      isTemplate: kIsMacOS ? true : false,
    );
    await Future.delayed(const Duration(milliseconds: 10));
    await trayManager.setContextMenu(
      Menu(
        items: [
          MenuItem(key: 'quit', label: 'Quit GitmojiApp'),
        ],
      ),
    );
  }

  Future<void> _windowShow({
    bool isShowBelowTray = false,
  }) async {
    bool isAlwaysOnTop = await windowManager.isAlwaysOnTop();
    Size windowSize = await windowManager.getSize();

    if (kIsMacOS && isShowBelowTray) {
      Rect? trayIconBounds = await trayManager.getBounds();
      if (trayIconBounds != null) {
        Size trayIconSize = trayIconBounds.size;
        Offset trayIconPosition = trayIconBounds.topLeft;

        Offset newPosition = Offset(
          trayIconPosition.dx - ((windowSize.width - trayIconSize.width) / 2),
          trayIconPosition.dy,
        );

        if (!isAlwaysOnTop) {
          await windowManager.setPosition(newPosition);
        }
      }
    }

    bool isVisible = await windowManager.isVisible();
    if (!isVisible) {
      await windowManager.show();
    } else {
      await windowManager.focus();
    }

    // Linux 下无法激活窗口临时解决方案
    if (kIsLinux && !isAlwaysOnTop) {
      await windowManager.setAlwaysOnTop(true);
      await Future.delayed(const Duration(milliseconds: 10));
      await windowManager.setAlwaysOnTop(false);
      await Future.delayed(const Duration(milliseconds: 10));
      await windowManager.focus();
    }
  }

  Future<void> _windowHide() async {
    await windowManager.hide();
  }

  @override
  void onWindowFocus() async {
    _focusNode.requestFocus();
  }

  @override
  void onWindowBlur() async {
    _focusNode.unfocus();
    bool isAlwaysOnTop = await windowManager.isAlwaysOnTop();
    if (!isAlwaysOnTop) {
      _windowHide();
    }
  }

  @override
  void onTrayIconMouseDown() async {
    _windowShow(isShowBelowTray: true);
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'quit':
        await trayManager.destroy();
        exit(0);
    }
  }
}
