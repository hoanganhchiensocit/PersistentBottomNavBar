part of persistent_bottom_nav_bar;

class BottomNavStyle20 extends StatelessWidget {
  const BottomNavStyle20({
    final Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);
  final NavBarEssentials? navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item, final bool isSelected, final double? height) => navBarEssentials!.navBarHeight == 0
      ? const SizedBox.shrink()
      : AnimatedContainer(
          height: height,
          duration: const Duration(milliseconds: 1000),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(navBarEssentials?.navBarHeight ?? 100)),
            color: isSelected ? const Color(0xFFF2F3F5) : Colors.white,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            alignment: Alignment.center,
            height: height,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: IconTheme(
                        data: IconThemeData(
                            size: item.iconSize,
                            color: isSelected
                                ? (item.activeColorSecondary ?? item.activeColorPrimary)
                                : item.inactiveColorPrimary ?? item.activeColorPrimary),
                        child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
                      ),
                    ),
                    if (item.title == null)
                      const SizedBox.shrink()
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Material(
                          type: MaterialType.transparency,
                          child: FittedBox(
                              child: Text(
                            item.title!,
                            style: item.textStyle != null
                                ? (item.textStyle!
                                    .apply(color: isSelected ? (item.activeColorSecondary ?? item.activeColorPrimary) : item.inactiveColorPrimary))
                                : TextStyle(
                                    color: isSelected ? (item.activeColorSecondary ?? item.activeColorPrimary) : item.inactiveColorPrimary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                          )),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        );

  @override
  Widget build(final BuildContext context) => SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        height: navBarEssentials!.navBarHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(navBarEssentials?.navBarHeight ?? 100)),
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0xFFE9E9E9), offset: Offset(1, 3))]),
        padding: EdgeInsets.only(
            left: navBarEssentials!.padding?.left ?? MediaQuery.of(context).size.width * 0.04,
            right: navBarEssentials!.padding?.right ?? MediaQuery.of(context).size.width * 0.04,
            top: navBarEssentials!.padding?.top ?? navBarEssentials!.navBarHeight! * 0.15,
            bottom: navBarEssentials!.padding?.bottom ?? navBarEssentials!.navBarHeight! * 0.12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navBarEssentials!.items!.map((final item) {
            final int index = navBarEssentials!.items!.indexOf(item);

            return Flexible(
                child: GestureDetector(
              onTap: () {
                if (navBarEssentials!.items![index].onPressed != null) {
                  navBarEssentials!.items![index].onPressed!(navBarEssentials!.selectedScreenBuildContext);
                } else {
                  navBarEssentials!.onItemSelected!(index);
                }
              },
              child: _buildItem(item, navBarEssentials!.selectedIndex == index, navBarEssentials!.navBarHeight),
            ));
          }).toList(),
        ),
      ));
}
