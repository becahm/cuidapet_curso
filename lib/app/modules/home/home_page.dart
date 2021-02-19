import 'package:cuidapet_curso/app/models/category_model.dart';
import 'package:cuidapet_curso/app/modules/home/components/home_appbar.dart';
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
      body: SingleChildScrollView(
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
                          FlatButton(
                            shape: CircleBorder(),
                            color: ThemeUtils.primaryColorLight,
                            height: 50,
                            onPressed: () {},
                            child: Icon(categoriesIcons[category.tipo]),
                          ),
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
              _buildPlacesList(),
              _buildPlacesGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlacesList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 40),
                width: ScreenUtil.screenWidthDp,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Oh my dog'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.grey,
                              ),
                              Text('2.65 km de distância'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                        height: 30,
                        shape: CircleBorder(),
                        color: ThemeUtils.primaryColor,
                        onPressed: () {},
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[100], width: 4),
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://image.freepik.com/vetores-gratis/petshop-com-gato-e-cachorro_9645-763.jpg'),
                    ),
                  ),
                  height: 60,
                  width: 60,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlacesGrid() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              margin: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Container(
                height: 120,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 55.0),
                      child: Text(
                        'Oh My Dog',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('2.65 km de distância'),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child:
                    CircleAvatar(radius: 40, backgroundColor: Colors.grey[100]),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 5,
              child: Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/vetores-gratis/petshop-com-gato-e-cachorro_9645-763.jpg'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
