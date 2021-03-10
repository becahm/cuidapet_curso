import 'package:cuidapet_curso/app/models/category_model.dart';
import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/modules/home/components/home_appbar.dart';
import 'package:cuidapet_curso/app/modules/home/components/provider_grid_item.dart';
import 'package:cuidapet_curso/app/modules/home/components/provider_list_item.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  HomeAppBar appBar;
  final categoriesIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store
  };
  final _placePageController = PageController(initialPage: 0);

  _HomePageState() {
    appBar = HomeAppBar(controller);
  }

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Drawer(),
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () => controller.getProviders(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: ScreenUtil.screenHeightDp -
                appBar.preferredSize.height -
                ScreenUtil.statusBarHeight,
            width: double.infinity,
            child: Column(
              children: [
                _buildAddress(),
                _buildCategories(),
                Expanded(child: _buildPlaces()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Estabelecimentos próximos de '),
          Observer(builder: (_) {
            return Text(
              controller.selectedAddress?.endereco ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoryModel>>(
        future: controller.categoriesFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar categorias!'));
              }
              if (snapshot.hasData) {
                final categories = snapshot.data;

                return Container(
                  padding: EdgeInsets.all(20),
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return Column(
                        children: [
                          Observer(builder: (_) {
                            return FlatButton(
                              shape: CircleBorder(),
                              color:
                                  controller.selectedCategoryId == category.id
                                      ? ThemeUtils.primaryColor
                                      : ThemeUtils.primaryColorLight,
                              height: 50,
                              onPressed: () =>
                                  controller.filterCategory(category.id),
                              child: Icon(categoriesIcons[category.tipo]),
                            );
                          }),
                          SizedBox(height: 10),
                          Text(
                            category.nome,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }

              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  Widget _buildPlaces() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Observer(builder: (_) {
            return Row(
              children: [
                Text(
                  'Estabelecimentos',
                  style: TextStyle(fontSize: 14),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.view_headline,
                      color: controller.selectedPage == 0
                          ? Colors.black
                          : Colors.grey),
                  onPressed: () {
                    _placePageController.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.view_comfy,
                      color: controller.selectedPage == 1
                          ? Colors.black
                          : Colors.grey),
                  onPressed: () {
                    _placePageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease);
                  },
                ),
              ],
            );
          }),
        ),
        Expanded(
          child: PageView(
            controller: _placePageController,
            onPageChanged: (value) => controller.changeSelectedPage(value),
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildProvidersList(),
              _buildProvidersGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProvidersList() {
    return Observer(builder: (_) {
      return FutureBuilder<List<ProviderSearchModel>>(
        future: controller.providersFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar categorias!'));
              }
              if (snapshot.hasData) {
                final providers = snapshot.data;

                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: providers.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.transparent,
                  ),
                  itemBuilder: (context, index) {
                    final provider = providers[index];
                    return ProviderListItem(provider);
                  },
                );
              } else {
                return Container();
              }

              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  Widget _buildProvidersGrid() {
    return Observer(builder: (_) {
      return FutureBuilder(
        future: controller.providersFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar categorias!'));
              }
              if (snapshot.hasData) {
                final providers = snapshot.data;

                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: providers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final provider = providers[index];
                    return ProviderGridItem(provider);
                  },
                );
              } else {
                return Container();
              }

              break;
            default:
              return Container();
          }
        },
      );
    });
  }
}
