import 'package:cuidapet_curso/app/models/provider_search_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ProviderListItem extends StatelessWidget {
  final ProviderSearchModel provider;
  const ProviderListItem(this.provider, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 40),
            width: ScreenUtil.screenWidthDp,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider.nome),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Text(
                              '${provider.distancia.toStringAsFixed(2)} km de distância'),
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
                  image: NetworkImage(provider.logo),
                ),
              ),
              height: 60,
              width: 60,
            ),
          )
        ],
      ),
    );
  }
}
