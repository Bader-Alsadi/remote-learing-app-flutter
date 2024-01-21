import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:remote_learing_app_frontend/core/constints/colors.dart';
import 'package:remote_learing_app_frontend/core/constints/image_paths.dart';
import 'package:remote_learing_app_frontend/core/constints/padding.dart';
import 'package:remote_learing_app_frontend/core/constints/text_style.dart';
import 'package:remote_learing_app_frontend/core/helpers/get_storge_helper.dart';
import 'package:remote_learing_app_frontend/core/widgets/costom_tap_view.dart';
import 'package:remote_learing_app_frontend/core/widgets/custom_icon.dart';
import 'package:remote_learing_app_frontend/featuer/models/chat_model.dart';
import 'package:remote_learing_app_frontend/featuer/view_models/course_vm.dart';
import 'package:remote_learing_app_frontend/featuer/views/dashbord_page/dashbord_page.dart';
import 'package:remote_learing_app_frontend/featuer/views/student_corces/widgets/student_course_appbar.dart';
// import 'package:timeago/timeago.dart' as timeago;

import '../../view_models/chat_vm.dart';
import 'chat_page.dart';

class ChatList extends StatefulWidget {
  ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  int _selectedTag = 0;

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  TextEditingController searshCon = TextEditingController();
  GetStorage instanceGetStorge = GetStorageHelper.instance("user");
  List user = List.generate(15, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        foregroundColor: WHITH_COLOR,
        centerTitle: true,
        title: Text(
          "messages",
          style: TEXT_BIG,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Circalicon(
              iconData: Icons.add,
              color: WHITH_COLOR,
              onTap: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child:


        Container(
          color: PRIMARY_COLOR,
          child: Column(
            children: [
              Text("Wisal",style: TITLE.copyWith(color: WHITH_COLOR),),
              SizedBox(
                height: SMALL_SPACER,
              ),
              chatListIndve(),
            ],
          ),
        ),
      ),
    );
  }
}

class chatListIndve extends StatelessWidget {
  const chatListIndve({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatVM>(context);
    chatProvider.loadChat(Provider.of<CoucesVM>(context).enrolmentIds());
    return Container(
      padding: EdgeInsets.all(MIN_SPACER),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(RADIUS),
            topRight: Radius.circular(RADIUS)),
        color: WHITH_COLOR,
      ),
      margin: EdgeInsets.only(top: SPACER),
      child: Column(
        children: [
          if (chatProvider.chats.isNotEmpty)
            ...chatProvider.chats
                .map<Widget>(
                  (e) => ListTile(
                    onTap: (){
                      chatProvider.loadMessages(e);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatTelegramRoute(subjectChat: e,)));
                    },
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              DecorationImage(image: AssetImage(PLACE_HOLDER))),
                    ),
                    title:
                        NotmalWhitText(value: e.subjectName!),
                    subtitle:
                        NotmalGrayText(value: e.lastMessage!),
                    trailing: Text(
                      "15 Oct",
                      style: GRAY_TEXT.copyWith(
                          color: PRIMARY_COLOR.withOpacity(0.7), fontSize: 14),
                    ),
                  ),
                )
                .toList(),
          if (chatProvider.chats.isEmpty) ...[
            Expanded(child: Container(child: Center(child: Text("no chat")))),
          ],
        ],
      ),
    );
  }
}
