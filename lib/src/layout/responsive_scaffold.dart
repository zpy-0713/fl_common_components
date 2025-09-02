import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'responsive_utils.dart';

// The default width of the side menu when expanded to full menu.
const double _kMenuWidth = 280;

// The default width of the side menu when collapsed to a rail.
const double _kRailWidth = 52;

// The minimum media size needed for desktop/large tablet menu view.
const double _kBreakpointShowFullMenu = 600;

// Menu animation duration.
const Duration _kMenuAnimationDuration = Duration(milliseconds: 246);

/// Used to define tap items for the the responsive Scaffold menu.
@immutable
class ResponsiveMenuItems {
  const ResponsiveMenuItems({
    this.label = '',
    this.icon = Icons.info,
    this.route = '',
    this.dividerAbove = false,
    this.dividerBelow = false,
    this.turns = 0,
    this.turnsSecondary = 0,
    String? tooltip,
    String? labelSecondary,
    String? tooltipSecondary,
    IconData? iconSecondary,
  })  : _tooltip = tooltip,
        _labelSecondary = labelSecondary,
        _tooltipSecondary = tooltipSecondary,
        _iconSecondary = iconSecondary;

  final String label;
  final IconData icon;
  final String? route;
  final String? _tooltip;
  final String? _labelSecondary;
  final String? _tooltipSecondary;
  final IconData? _iconSecondary;
  final bool dividerAbove;
  final bool dividerBelow;
  final int turns;
  final int turnsSecondary;

  String get tooltip => _tooltip ?? label;
  String get labelSecondary => _labelSecondary ?? label;
  String get tooltipSecondary =>
      _tooltipSecondary ?? _labelSecondary ?? tooltip;
  IconData get iconSecondary => _iconSecondary ?? icon;
}

/// Used to define menu categories with sub-items for the responsive Scaffold menu.
@immutable
class ResponsiveMenuCategory {
  const ResponsiveMenuCategory({
    required this.title,
    required this.subItems,
    this.isExpanded = false,
    this.dividerAbove = false,
    this.dividerBelow = false,
    String? tooltip,
  }) : _tooltip = tooltip;

  final String title;
  final List<ResponsiveMenuItems> subItems;
  final bool isExpanded;
  final bool dividerAbove;
  final bool dividerBelow;
  final String? _tooltip;

  String get tooltip => _tooltip ?? title;
}

// Enum used to represent available icon states in the responsive Scaffold
enum ResponsiveMenuItemIconState { primary, secondary }

/// A simplistic animated responsive Scaffold.
///
/// This is a responsive animated Scaffold that can adapt to different screen sizes.
/// It provides a side menu that can be collapsed to a rail or expanded to a full menu.
class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({
    super.key,
    this.title,
    this.menuTitle,
    this.menuLeadingTitle,
    this.menuLeadingSubtitle,
    this.menuLeadingAvatarLabel,
    this.menuItems,
    this.menuItemsEnabled,
    this.menuItemsIconState,
    this.menuCategories,
    this.onSelect,
    this.onCategoryToggle,
    this.railWidth = _kRailWidth,
    this.menuWidth = _kMenuWidth,
    this.breakpointShowFullMenu = _kBreakpointShowFullMenu,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.onAbout,
    this.onSettings,
    this.onLogout,
  });

  /// The primary widget displayed in the app bar
  final Widget? title;

  /// The widget displayed in the app bar on the menu as app title or a logo
  final Widget? menuTitle;

  /// A title for leading menu item
  final Widget? menuLeadingTitle;

  /// A subtitle for leading menu item
  final Widget? menuLeadingSubtitle;

  /// A label for the avatar for the leading menu item
  final Widget? menuLeadingAvatarLabel;

  /// Responsive menu tap items
  final List<ResponsiveMenuItems>? menuItems;

  /// Responsive menu tap items enabled/disabled
  final List<bool>? menuItemsEnabled;

  /// Responsive menu tap items used icon state
  final List<ResponsiveMenuItemIconState>? menuItemsIconState;

  /// Responsive menu categories with sub-items
  final List<ResponsiveMenuCategory>? menuCategories;

  /// Callback called with menu index when user taps on a menu item
  final ValueChanged<int>? onSelect;

  /// Callback called when a category is toggled (expanded/collapsed)
  final ValueChanged<int>? onCategoryToggle;

  /// The width of the menu when it is rail sized
  final double railWidth;

  /// The width of the menu when it is full sized
  final double menuWidth;

  /// Breakpoint when we want to show the full sized menu
  final double breakpointShowFullMenu;

  /// The primary content of the scaffold
  final Widget? body;

  /// A button displayed floating above body
  final Widget? floatingActionButton;

  /// Responsible for determining where the floatingActionButton should go
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator to move the floatingActionButton to a new location
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// A set of buttons that are displayed at the bottom of the scaffold
  final List<Widget>? persistentFooterButtons;

  /// Optional callback that is called when the Scaffold.drawer is opened or closed
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed to the side of the body
  final Widget? endDrawer;

  /// Optional callback that is called when the Scaffold.endDrawer is opened or closed
  final DrawerCallback? onEndDrawerChanged;

  /// A bottom navigation bar to display at the bottom of the scaffold
  final Widget? bottomNavigationBar;

  /// The persistent bottom sheet to display
  final Widget? bottomSheet;

  /// The color of the Material widget that underlies the entire Scaffold
  final Color? backgroundColor;

  /// If true the body and the scaffold's floating widgets should size themselves to avoid the onscreen keyboard
  final bool? resizeToAvoidBottomInset;

  /// Whether this scaffold is being displayed at the top of the screen
  final bool primary;

  /// Configuration of offset passed to DragStartDetails
  final DragStartBehavior drawerDragStartBehavior;

  /// If true, and bottomNavigationBar or persistentFooterButtons is specified, then the body extends to the bottom of the Scaffold
  final bool extendBody;

  /// If true, and an AppBar is specified, then the height of the body is extended to include the height of the app bar
  final bool extendBodyBehindAppBar;

  /// The color to use for the scrim that obscures primary content while a drawer is open
  final Color? drawerScrimColor;

  /// The width of the area within which a horizontal swipe will open the drawer
  final double? drawerEdgeDragWidth;

  /// Determines if the Scaffold.drawer can be opened with a drag gesture
  final bool drawerEnableOpenDragGesture;

  /// Determines if the Scaffold.endDrawer can be opened with a drag gesture
  final bool endDrawerEnableOpenDragGesture;

  /// Restoration ID to save and restore the state of the Scaffold
  final String? restorationId;

  /// Callback for the "About" button
  final VoidCallback? onAbout;

  /// Callback for the "Settings" button
  final VoidCallback? onSettings;

  /// Callback for the "Logout" button
  final VoidCallback? onLogout;

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  late double activeMenuWidth;
  late double previousMenuWidth;
  bool isMenuExpanded = true;
  bool isMenuClosed = false;
  bool menuDoneClosing = false;
  late List<bool> menuItemsEnabled;
  late List<ResponsiveMenuItemIconState> menuItemsIconState;
  late Size previousMediaSize;

  @override
  void didUpdateWidget(covariant ResponsiveScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    final Size mediaSize = MediaQuery.sizeOf(context);
    if (mediaSize != previousMediaSize) {
      previousMediaSize = mediaSize;
      final bool isTablet = mediaSize.width < widget.breakpointShowFullMenu;
      if (isTablet) {
        isMenuClosed = true;
      } else {
        isMenuClosed = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    previousMediaSize = Size.zero;
    activeMenuWidth = widget.menuWidth;
    previousMenuWidth = activeMenuWidth;
    
    final int regularMenuItemsCount = widget.menuItems?.length ?? 0;
    final int categorySubItemsCount = widget.menuCategories != null
        ? widget.menuCategories!
            .map((ResponsiveMenuCategory category) => category.subItems.length)
            .reduce((int a, int b) => a + b)
        : 0;
    final int totalMenuItemsCount =
        regularMenuItemsCount + categorySubItemsCount;

    menuItemsEnabled =
        List<bool>.generate(totalMenuItemsCount, (int i) => true);
    if (widget.menuItemsEnabled != null) {
      if ((widget.menuItemsEnabled?.length ?? 0) == totalMenuItemsCount) {
        menuItemsEnabled = widget.menuItemsEnabled!;
      }
    }

    menuItemsIconState = List<ResponsiveMenuItemIconState>.generate(
        totalMenuItemsCount, (int i) => ResponsiveMenuItemIconState.primary);
    if (widget.menuItemsIconState != null) {
      if ((widget.menuItemsIconState?.length ?? 0) == totalMenuItemsCount) {
        menuItemsIconState = widget.menuItemsIconState!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop =
        MediaQuery.sizeOf(context).width >= widget.breakpointShowFullMenu;
    
    if (!isDesktop) activeMenuWidth = widget.railWidth;
    if (!isDesktop && isMenuClosed) activeMenuWidth = 0;
    if (!isDesktop && !isMenuClosed) activeMenuWidth = widget.railWidth;
    if (isDesktop && !isMenuExpanded) activeMenuWidth = widget.railWidth;
    if (isDesktop && isMenuExpanded) activeMenuWidth = widget.menuWidth;

    return Row(
      children: <Widget>[
        FocusTraversalGroup(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widget.menuWidth),
            child: Material(
              child: AnimatedContainer(
                duration: _kMenuAnimationDuration,
                onEnd: () {
                  setState(() {
                    if (isMenuClosed) {
                      menuDoneClosing = true;
                    } else {
                      menuDoneClosing = false;
                    }
                  });
                },
                width: activeMenuWidth,
                child: _AppMenu(
                  title: widget.menuTitle,
                  menuLeadingTitle: widget.menuLeadingTitle,
                  menuLeadingSubtitle: widget.menuLeadingSubtitle,
                  menuLeadingAvatarLabel: widget.menuLeadingAvatarLabel,
                  menuItems: widget.menuItems ?? <ResponsiveMenuItems>[],
                  menuItemsEnabled: menuItemsEnabled,
                  menuItemsIconState: menuItemsIconState,
                  menuCategories: widget.menuCategories,
                  maxWidth: widget.menuWidth,
                  railWidth: widget.railWidth,
                  onSelect: widget.onSelect,
                  onCategoryToggle: widget.onCategoryToggle,
                  onAbout: widget.onAbout,
                  onSettings: widget.onSettings,
                  onLogout: widget.onLogout,
                  onOperate: () {
                    setState(() {
                      isMenuExpanded = !isMenuExpanded;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FocusTraversalGroup(
            child: Scaffold(
              drawer: ConstrainedBox(
                constraints: BoxConstraints.expand(width: widget.menuWidth),
                child: Drawer(
                  child: _AppMenu(
                    title: widget.menuTitle,
                    menuLeadingTitle: widget.menuLeadingTitle,
                    menuLeadingSubtitle: widget.menuLeadingSubtitle,
                    menuLeadingAvatarLabel: widget.menuLeadingAvatarLabel,
                    menuItems: widget.menuItems ?? <ResponsiveMenuItems>[],
                    menuItemsEnabled: menuItemsEnabled,
                    menuItemsIconState: menuItemsIconState,
                    menuCategories: widget.menuCategories,
                    maxWidth: widget.menuWidth,
                    railWidth: widget.railWidth,
                    onSelect: (int index) {
                      Navigator.of(context).pop();
                      widget.onSelect?.call(index);
                    },
                    onCategoryToggle: widget.onCategoryToggle,
                    onAbout: widget.onAbout,
                    onSettings: widget.onSettings,
                    onLogout: widget.onLogout,
                    onOperate: () {
                      Navigator.of(context).pop();
                      Future<void>.delayed(_kMenuAnimationDuration, () {
                        setState(() {
                          isMenuClosed = false;
                        });
                      });
                    },
                  ),
                ),
              ),
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
              floatingActionButtonLocation: widget.floatingActionButtonLocation,
              floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
              persistentFooterButtons: widget.persistentFooterButtons,
              onDrawerChanged: widget.onDrawerChanged,
              endDrawer: widget.endDrawer,
              onEndDrawerChanged: widget.onEndDrawerChanged,
              bottomNavigationBar: widget.bottomNavigationBar,
              bottomSheet: widget.bottomSheet,
              backgroundColor: widget.backgroundColor,
              resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
              primary: widget.primary,
              drawerDragStartBehavior: widget.drawerDragStartBehavior,
              extendBody: widget.extendBody,
              extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
              drawerScrimColor: widget.drawerScrimColor,
              drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
              drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
              endDrawerEnableOpenDragGesture:
                  widget.endDrawerEnableOpenDragGesture,
              restorationId: widget.restorationId,
            ),
          ),
        ),
      ],
    );
  }
}

/// App side menu and rail
class _AppMenu extends StatefulWidget {
  const _AppMenu({
    this.title,
    required this.maxWidth,
    this.onOperate,
    this.onSelect,
    required this.railWidth,
    this.menuLeadingTitle,
    this.menuLeadingSubtitle,
    this.menuLeadingAvatarLabel,
    required this.menuItems,
    required this.menuItemsEnabled,
    required this.menuItemsIconState,
    this.menuCategories,
    this.onCategoryToggle,
    this.onAbout,
    this.onSettings,
    this.onLogout,
  });
  
  final Widget? title;
  final double maxWidth;
  final VoidCallback? onOperate;
  final ValueChanged<int>? onSelect;
  final double railWidth;
  final Widget? menuLeadingTitle;
  final Widget? menuLeadingSubtitle;
  final Widget? menuLeadingAvatarLabel;
  final List<ResponsiveMenuItems> menuItems;
  final List<bool> menuItemsEnabled;
  final List<ResponsiveMenuItemIconState> menuItemsIconState;
  final List<ResponsiveMenuCategory>? menuCategories;
  final ValueChanged<int>? onCategoryToggle;
  final VoidCallback? onAbout;
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;

  @override
  _AppMenuState createState() => _AppMenuState();
}

class _AppMenuState extends State<_AppMenu> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return OverflowBox(
          alignment: AlignmentDirectional.topStart,
          minWidth: 0,
          maxWidth: widget.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBar(
                title: widget.title,
                titleSpacing: 0,
                leadingWidth: widget.railWidth,
                automaticallyImplyLeading: false,
                leading: !ResponsiveUtils.isDesktop(context)
                    ? null
                    : IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.menu),
                        onPressed: widget.onOperate,
                      ),
              ),
              Expanded(
                child: ClipRect(
                  child: OverflowBox(
                    alignment: AlignmentDirectional.topStart,
                    minWidth: 0,
                    maxWidth: widget.maxWidth,
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        if (widget.menuItems.isNotEmpty)
                          ...widget.menuItems
                              .asMap()
                              .entries
                              .map((MapEntry<int, ResponsiveMenuItems> entry) {
                            final int i = entry.key;
                            final ResponsiveMenuItems item = entry.value;
                            return _MenuItem(
                              width: size.maxWidth,
                              menuWidth: widget.maxWidth,
                              onTap: () {
                                setState(() {
                                  selectedItem = i;
                                });
                                // Route navigation would be handled by the parent widget
                                // if (item.route != null && item.route!.isNotEmpty) {
                                //   context.goNamed(item.route!);
                                // }
                                widget.onSelect?.call(i);
                              },
                              selected: selectedItem == i,
                              icon: widget.menuItemsIconState[i] ==
                                      ResponsiveMenuItemIconState.primary
                                  ? item.icon
                                  : item.iconSecondary,
                              turns: widget.menuItemsIconState[i] ==
                                      ResponsiveMenuItemIconState.primary
                                  ? item.turns
                                  : item.turnsSecondary,
                              label: widget.menuItemsIconState[i] ==
                                      ResponsiveMenuItemIconState.primary
                                  ? item.label
                                  : item.labelSecondary,
                              tooltip: widget.menuItemsIconState[i] ==
                                      ResponsiveMenuItemIconState.primary
                                  ? item.tooltip
                                  : item.tooltipSecondary,
                              enabled: widget.menuItemsEnabled[i],
                              dividerAbove: item.dividerAbove,
                              dividerBelow: item.dividerBelow,
                              railWidth: widget.railWidth,
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ),
              _MenuLeadingItem(
                railWidth: widget.railWidth,
                menuLeadingTitle: widget.menuLeadingTitle,
                menuLeadingSubtitle: widget.menuLeadingSubtitle,
                menuLeadingAvatarLabel: widget.menuLeadingAvatarLabel,
                onAbout: widget.onAbout,
                onSettings: widget.onSettings,
                onLogout: widget.onLogout,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// The items for the menu
class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.width,
    required this.menuWidth,
    required this.onTap,
    this.selected = false,
    required this.icon,
    required this.turns,
    required this.label,
    required this.tooltip,
    this.dividerAbove = false,
    this.dividerBelow = false,
    required this.railWidth,
    this.enabled = true,
  });

  final double width;
  final double menuWidth;
  final VoidCallback onTap;
  final bool selected;
  final IconData icon;
  final int turns;
  final String label;
  final String tooltip;
  final bool dividerAbove;
  final bool dividerBelow;
  final double railWidth;
  final bool enabled;

  static const double _itemHeight = 44;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color iconColor = enabled
        ? isLight
            ? Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x99),
                theme.colorScheme.onSurface)
            : Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x7F),
                theme.colorScheme.onSurface)
        : theme.colorScheme.onSurface.withAlpha(0x55);
    final Color textColor = enabled
        ? theme.colorScheme.onSurface.withAlpha(0xCC)
        : theme.colorScheme.onSurface.withAlpha(0x55);
    final double endPadding = (width > railWidth + 10)
        ? 12
        : railWidth < 60
            ? 5
            : 8;
    
    if (width < 4) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (dividerAbove) const Divider(thickness: 1, height: 1),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 1, endPadding, 1),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(_MenuItem._itemHeight / 2),
                bottomRight: Radius.circular(_MenuItem._itemHeight / 2),
              ),
              color: Colors.transparent,
              child: SizedBox(
                height: _MenuItem._itemHeight,
                width: math.max(width - endPadding, 0),
                child: OverflowBox(
                  alignment: AlignmentDirectional.topStart,
                  minWidth: 0,
                  maxWidth: math.max(menuWidth, 0),
                  child: InkWell(
                    onTap: enabled ? onTap : null,
                    child: Row(
                      children: <Widget>[
                        Tooltip(
                          message: width == railWidth && enabled ? tooltip : '',
                          margin: const EdgeInsetsDirectional.only(start: 50),
                          waitDuration: const Duration(milliseconds: 500),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: railWidth,
                              height: railWidth,
                            ),
                            child: turns == 0
                                ? Icon(icon, color: iconColor)
                                : RotatedBox(
                                    quarterTurns: turns,
                                    child: Icon(icon, color: iconColor),
                                  ),
                          ),
                        ),
                        if (width < railWidth + 10)
                          const SizedBox.shrink()
                        else
                          Text(
                            label,
                            style: theme.textTheme.titleSmall!.copyWith(
                                color: textColor, fontWeight: FontWeight.w600),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

/// Example of a leading item for the entire menu
class _MenuLeadingItem extends StatefulWidget {
  const _MenuLeadingItem({
    required this.railWidth,
    this.menuLeadingTitle,
    this.menuLeadingSubtitle,
    this.menuLeadingAvatarLabel,
    this.onAbout,
    this.onSettings,
    this.onLogout,
  });
  
  final double railWidth;
  final Widget? menuLeadingTitle;
  final Widget? menuLeadingSubtitle;
  final Widget? menuLeadingAvatarLabel;
  final VoidCallback? onAbout;
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;

  @override
  _MenuLeadingItemState createState() => _MenuLeadingItemState();
}

class _MenuLeadingItemState extends State<_MenuLeadingItem> {
  bool _collapsed = true;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const double hPadding = 3;

    return Focus(
      focusNode: _focusNode,
      child: Column(
        children: <Widget>[
          ListTile(
            visualDensity: VisualDensity.comfortable,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: hPadding,
              vertical: hPadding,
            ),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.secondaryContainer,
              radius: widget.railWidth / 2 - hPadding,
              child: widget.menuLeadingAvatarLabel,
            ),
            title: widget.menuLeadingTitle,
            subtitle: widget.menuLeadingSubtitle,
            trailing: ExpandIcon(
              isExpanded: !_collapsed,
              size: 32,
              padding: EdgeInsets.zero,
              onPressed: (_) {
                _focusNode.requestFocus();
                setState(() {
                  _collapsed = !_collapsed;
                });
              },
            ),
            onTap: () {
              _focusNode.requestFocus();
              setState(() {
                _collapsed = !_collapsed;
              });
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: child,
              );
            },
            child: _collapsed
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: <Widget>[
                        const Spacer(),
                        TextButton(
                          onPressed: widget.onAbout,
                          child: Column(
                            children: <Widget>[
                              const Icon(Icons.info, size: 30),
                              Text('关于', style: theme.textTheme.labelSmall),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onSettings,
                          child: Column(
                            children: <Widget>[
                              const Icon(Icons.person, size: 30),
                              Text('个人信息', style: theme.textTheme.labelSmall),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onLogout,
                          child: Column(
                            children: <Widget>[
                              const Icon(Icons.logout, size: 30),
                              Text('退出登录', style: theme.textTheme.labelSmall),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
