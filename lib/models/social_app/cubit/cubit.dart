
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled13/models/post_model/Post_model.dart';
import 'package:untitled13/models/social_app/cubit/states.dart';
import 'package:untitled13/models/social_app/message_model.dart';
import 'package:untitled13/modules/social_app/chat/chat_screen.dart';
import 'package:untitled13/modules/social_app/feed/feed_screen.dart';
import 'package:untitled13/modules/social_app/newpost/new_post.dart';
import 'package:untitled13/modules/social_app/users/user_screen.dart';

import '../../../modules/social_app/settings/setting_screen.dart';
import '../../../shared/components/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../social_user_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() :super(SocialIinitalState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? usermodel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      usermodel = SocialUserModel.fromjson(value.data()!);
      // print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int CurrentIndex = 0;
  List<Widget>screens =
  [
    FeedScreen(),
    ChatScreen(),
    UserScreen(),
    NewsPostScreen(),
    SocialSettingScreen(),
  ];
  List<String>title =
  [
    'Home',
    'Chat',
    'post',
    'Users',
    'Setting',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUser();
    }

    if (index == 2)
      emit(SocialNewPostState());
    else {
      CurrentIndex = index;
      emit(SocialChangeBottomNavState());
    }
    emit(SocialChangeBottomNavState());
  }

  File?ProfileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File?CoverImage;

  Future<void> getCoverImage() async {
    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void removePostImage() {
    PostImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadProfileImage({required String name,
    required String phone,
    required String bio,}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('user/${Uri
        .file(ProfileImage!.path)
        .pathSegments
        .last}').putFile(ProfileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        UpdateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
    //it will create a folder
  }

  void uploadCoverImage({ required String name,
    required String phone,
    required String bio,}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('user/${Uri
        .file(CoverImage!.path)
        .pathSegments
        .last}').putFile(CoverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        UpdateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
    //it will create a folder
  }

  File?PostImage;

  Future<void> getPostImage() async {
    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void UploadPostImage({

    required String?dateTime,
    required String?text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri
        .file(PostImage!.path)
        .pathSegments
        .last}').putFile(PostImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        CreatePostImage(dateTime: dateTime, text: text, postImage: value,);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
    //it will create a folder
  }

  // void UpdateUSerImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // })
  // {
  //   emit(SocialUserUpdateLoadingState());
  //   if(CoverImage!=null)
  //   {
  //     uploadCoverImage();
  //   }else if(ProfileImage!=null)
  //   {
  //     uploadProfileImage();
  //   }
  //   else if(CoverImage!=null&&ProfileImage!=null)
  //   {
  //
  //   }else
  //   {
  //    UpdateUser(name: name, phone: phone, bio: bio);
  //   }
  //
  //
  // }
  void CreatePostImage({
    required String?dateTime,
    required String?text,
    String?postImage,

  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(name: usermodel!.name,
        image: usermodel!.image,
        uId: usermodel!.uId,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');
    FirebaseFirestore.instance.collection('posts').add(model.ToMap()).then((
        value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void UpdateUser({
    required String name,
    required String phone,
    required String bio,
    String?cover,
    String?image,

  }) {
    SocialUserModel model = SocialUserModel(
        phone: phone,
        name: name,
        uId: usermodel!.uId,
        email: usermodel!.email,
        Cover: cover ?? usermodel!.Cover,
        image: image ?? usermodel!.image,
        bio: bio,
        isEmailVerified: false
    );
    FirebaseFirestore.instance.collection('user').doc(usermodel!.uId).update(
        model.ToMap()).then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  List<PostModel>posts = [];
  List<String>postsId = [];
  List<int>Likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        print(element.id);
        element.reference.collection('likes').get().then((value) {
          Likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void LikePost(String PostId) {
    FirebaseFirestore.instance.
    collection('posts').
    doc(PostId).
    collection('likes')
        .doc(usermodel!.uId).
    set({
      'like': true,
    }).
    then((value) {
      emit(SocialLikePostSuccessState());
    }).
    catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel>users = [];

  void getUser() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != usermodel!.uId)
            // هيجيب غيرى ID
            users.add(SocialUserModel.fromjson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

  void SendMessage({
    required String?receiverId,
    required String?dateTime,
    required String?text,
  }) {
    MessageModel model = MessageModel(text: text,
        senderID: usermodel!.uId,
        receiverId: receiverId,
        datetime: dateTime);
    // set my chat
    FirebaseFirestore.instance.collection('user').doc(usermodel!.uId).collection('chats').doc(
        receiverId).collection('messages').add(model.ToMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });
    // set receiver chat
    FirebaseFirestore.instance.collection('user').doc(receiverId).collection('chats').doc(
        usermodel!.uId).collection('messages').add(model.ToMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

  }
List<MessageModel>messages=[];
  void getMessages({
    required String?receiverId,
})
{
FirebaseFirestore.instance
    .collection('user').doc(usermodel!.uId)
.collection('chats').doc(receiverId)
    .collection('messages')
     // .orderBy('dateTime')
    .snapshots()
    .listen((event)
{
  messages=[];
  // علشان ميجبش الجديد والقديم
event.docs.forEach((element)
{
 messages.add(MessageModel.fromjson(element.data()));
 });
emit(SocialGetMessagesSuccessState());
});
}

//   List<MessageModel>message=[];
//   void getMessage({
//     required String?receiverId,
// })
//   {
//     FirebaseFirestore.instance.collection('user').
//     doc(usermodel!.uId).collection('chats').
//     doc(receiverId).collection('messages').snapshots().
//     listen((event)
//     {
//       message=[];
//       // علشان ميجبش الجديد والقديم
//       event.docs.forEach((element)
//       {
//      message.add(MessageModel.fromjson(element.data()));
//       });
//       emit(SocialGetMessagesSuccessState());
//     });
//   }
}