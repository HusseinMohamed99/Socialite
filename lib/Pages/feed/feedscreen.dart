import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                color: SocialCubit.get(context).isDark
                    ? Colors.white
                    : const Color(0xff063750),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/pretty-glad-brunette-asian-woman-stands-half-turned-against-pink-wall-has-good-mood-wears-stylish-jacket-with-hood-thinks-about-something-pleasant-poses-happy-indoor-emotions-concept_273609-49492.jpg?w=996&t=st=1659816072~exp=1659816672~hmac=b1e282848af61fe758af6d13ce63e6c063cb315d090b8304c1ed0c7cb5a22b32'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 220,
                          height: 50,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.grey[300]),
                            ),
                            child: Text(
                              '\' What\'s on your mind ? \'',
                              style: GoogleFonts.lobster(
                                fontSize: 16,
                                color: SocialCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.grey,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.photo_library_outlined,
                          size: 30,
                          color: cubit.isDark
                              ? CupertinoColors.activeBlue
                              : Colors.white,
                        ),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),
              space(0, 10),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                separatorBuilder: (context, index) => space(0, 10),
                itemBuilder: (context, index) => (buildPostItem(context)),
              ),
              space(0, 10),
            ],
          ),
        );
      },
    );
  }
}
