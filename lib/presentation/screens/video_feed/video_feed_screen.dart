import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import '../../../core/helper/video_playback_manager.dart';
import '../../../core/resources/app_values.dart';
import '../../bloc/video_feed/video_feed_bloc.dart';
import '../../bloc/video_feed/video_feed_event.dart';
import '../../bloc/video_feed/video_feed_state.dart';
import '../../widgets/video/video_player_item.dart';
import '../../widgets/video/video_action_bar.dart';
import '../../widgets/video/video_description.dart';
import '../../widgets/video/video_failed_widget.dart';
import '../../widgets/video/video_empty_widget.dart';
import '../../widgets/video/custom_bottom_navigation.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {

  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();

  List<String> _initializedVideos = [];

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();

    VideoPlaybackManager.instance.dispose();

    super.dispose();
  }

 void _initializeVideoManager(List<dynamic> videos) {

  final List<String> urls = videos
      .map<String>((video) => video.videoUrl as String)
      .toList();


  final bool isChanged =
      _initializedVideos.length != urls.length ||
      !_initializedVideos.every(
        (url) => urls.contains(url),
      );


  if (isChanged) {

    _initializedVideos = urls;

    VideoPlaybackManager.instance.initializeFeed(
      urls,
    );

  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.black,

      body: BlocBuilder<VideoFeedBloc, IVideoFeedState>(

        builder: (context,state){


          if(state is VideoFeedLoading){
            return _buildLoadingScreen(context);
          }


          if(state is VideoFeedFailed){

            return VideoFailedWidget(

              onTryAgain: (){

                context.read<VideoFeedBloc>().add(

                  FetchVideosEvent(
                    query: 'nature',
                    isRefresh: true,
                  ),

                );

              },

            );

          }



          if(state is VideoFeedLoaded){

            final videos = state.videos;


            if(videos.isEmpty){

              return VideoEmptyWidget(

                onRefresh: (){

                  context.read<VideoFeedBloc>().add(

                    FetchVideosEvent(
                      query: state.query,
                      isRefresh:true,
                    ),

                  );

                },

              );

            }



            _initializeVideoManager(videos);



            return Stack(

              children: [


                PageView.builder(

                  controller:_pageController,

                  scrollDirection: Axis.vertical,

                  itemCount: videos.length,


                  onPageChanged:(index){

                    VideoPlaybackManager.instance
                        .onPageChanged(index);

                  },


                  itemBuilder:(context,index){


                    final video = videos[index];


                    return Stack(

                      children:[


                        VideoPlayerItem(

                          key:ValueKey(video.id),

                          index:index,

                          videoUrl:video.videoUrl,

                          thumbnailUrl:video.thumbnail,

                        ),



                        VideoActionBar(

                          likes:video.likesCount,

                          comments:video.commentsCount,

                          shares:video.sharesCount,

                          isLiked:video.isLiked,


                          onLike:(){

                            context.read<VideoFeedBloc>().add(

                              ToggleLikeVideoEvent(
                                videoId:video.id,
                              ),

                            );

                          },


                        ),



                        VideoDescription(

                          username:video.username,

                          caption:video.caption,

                        ),


                      ],

                    );

                  },

                ),



                _buildSearchButton(context),



                const Align(

                  alignment:Alignment.bottomCenter,

                  child:CustomBottomNavigation(),

                ),



              ],


            );

          }


          return const SizedBox.shrink();


        },


      ),


    );

  }



  Widget _buildLoadingScreen(BuildContext context){


    return Stack(

      children:[


        Container(

          width:double.infinity,

          height:double.infinity,

          color:AppColors.black,

        ),



        Center(

          child:Container(

            width:AppWidth.w240,


            padding:EdgeInsets.symmetric(

              vertical:AppPaddingHeight.p24,

              horizontal:AppPaddingWidth.p16,

            ),


            decoration:BoxDecoration(

              color:AppColors.white.withOpacity(.08),

              borderRadius:
              BorderRadius.circular(AppRadius.r16),

            ),


            child:Column(

              mainAxisSize:MainAxisSize.min,

              spacing:AppHeight.h15,


              children:[


                const CircularProgressIndicator(),



                const Text(

                  "Loading videos...",

                  style:TextStyle(
                    color:AppColors.white,
                  ),

                ),



              ],


            ),


          ),


        ),


      ],


    );

  }




  Widget _buildSearchButton(BuildContext context){


    return Positioned(

      top:MediaQuery.of(context).padding.top + AppHeight.h10,

      right:AppPaddingWidth.p15,


      child:IconButton(

        icon:const Icon(

          Icons.search,

          color: AppColors.white,

        ),


        onPressed:(){

          _showSearchDialog(context);

        },


      ),


    );

  }




  void _showSearchDialog(BuildContext context){


    showDialog(

      context:context,

      builder:(dialogContext){


        return AlertDialog(


          backgroundColor:AppColors.lightGrey,



          title:const Text(

            "Search Videos",

            style:TextStyle(
              color:AppColors.white,
            ),

          ),



          content:TextField(

            controller:_searchController,


            style:const TextStyle(
              color:AppColors.white,
            ),


            decoration:const InputDecoration(

              hintText:
              "Enter query",

            ),


          ),



          actions:[


            TextButton(

              onPressed:(){

                Navigator.pop(dialogContext);

              },


              child:const Text("Cancel"),

            ),




            ElevatedButton(

              onPressed:(){

                final query =
                _searchController.text.trim();



                if(query.isNotEmpty){

                  context.read<VideoFeedBloc>().add(

                    FetchVideosEvent(

                      query:query,

                      isRefresh:true,

                    ),

                  );

                }



                Navigator.pop(dialogContext);


              },


              child:const Text("Search"),


            ),


          ],


        );


      },


    );


  }


}