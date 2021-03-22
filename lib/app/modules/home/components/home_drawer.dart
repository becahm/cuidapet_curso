import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/services/user_service.dart';
import 'package:cuidapet_curso/app/shared/auth_store.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

class HomeDrawer extends Drawer {
  HomeDrawer()
      : super(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Observer(
              builder: (_) {
                final user = Modular.get<AuthStore>().loggedUser;
                return Column(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Align(
                            child: CircleAvatar(
                              backgroundImage: user.imgAvatar != null
                                  ? NetworkImage(user.imgAvatar)
                                  : null,
                              radius: 100,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () => _changeProfileImage(),
                              child: Container(
                                color: Colors.white60,
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text('Alterar imagem',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(user.email),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: Icon(Icons.receipt),
                          title: Text('Meus agendamentos'),
                        ),
                        ListTile(
                          leading: Icon(Icons.chat),
                          title: Text('Chats'),
                        ),
                        ListTile(
                          onTap: () async {
                            final prefs = await SharedPrefsRepository.instance;
                            await prefs.logout();
                          },
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Sair'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );

  static Future<void> _changeProfileImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.camera);

    if (imageFile != null) {
      Loader.show();
      final reference = FirebaseStorage.instance
          .ref()
          .child('/perfil/${DateTime.now().millisecondsSinceEpoch.toString()}');
      final storageTask =
          await reference.putFile(File(imageFile.path)).onComplete;
      final url = await storageTask.ref.getDownloadURL();
      print(url);
      final newUser = await Modular.get<UserService>().updateProfileImage(url);
      final prefs = await SharedPrefsRepository.instance;
      final oldImageUrl = prefs.acessUserData.imgAvatar;

      await prefs.registerUserData(newUser);
      await Modular.get<AuthStore>().loadUser();
      Loader.hide();
      Future.delayed(Duration(seconds: 3))
          .then((_) => deleteOldProfileImage(oldImageUrl));
    }
  }

  static Future<void> deleteOldProfileImage(String oldUrl) async {
    final storage = FirebaseStorage.instance;

    if (oldUrl != null) {
      final oldImageReference = await storage.getReferenceFromUrl(oldUrl);
      try {
        await oldImageReference.delete();
        print('Foto antiga deletada com sucesso');
      } catch (e) {
        print(e);
        print('Erro ao deletar foto antiga');
      }
    }
  }
}
