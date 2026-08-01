import 'package:tiktok/domain/entity/video/video_entity.dart';
import 'pexels_response_model.dart';

class VideoModelMapper {
  VideoModelMapper._();

  static VideoEntity toEntity(PexelsVideoItemModel model) {
    final idVal = model.id ?? 0;
    final videoFiles = model.videoFiles ?? [];

    // إصلاح ثغرة الفيديوهات الرأسية وتأمينها من الكراش البرمجي
    final bestFile = _getBestVideoFile(videoFiles);
    final selectedUrl = bestFile?.link ?? '';

    final pexelsUser = model.user?.name ?? 'Pexels Creator';
    final usernameClean = pexelsUser.toLowerCase().replaceAll(' ', '');

    // العدادات تبدأ من صفر التزاماً تاماً بمتطلبات التقويم الفني
    const int initialLikes = 0;
    const int initialComments = 0;
    const int initialShares = 0;

    // شرح بسيط للفيديو أو فارغ دون هاشتاغات وهمية
    const String caption = "Pexels video";

    return VideoEntity(
      id: idVal,
      videoUrl: selectedUrl,
      thumbnail: model.image ?? '',
      username: usernameClean,
      caption: caption,
      likesCount: initialLikes,
      commentsCount: initialComments,
      sharesCount: initialShares,
    );
  }

  static PexelsVideoFileModel? _getBestVideoFile(List<PexelsVideoFileModel> files) {
    if (files.isEmpty) return null;

    final verticalFiles = files.where((file) {
      final w = file.width ?? 0;
      final h = file.height ?? 0;
      return h > w;
    }).toList();

    // تأمين الكود البرمجي في حال عدم العثور على فيديوهات رأسية
    final candidateFiles = verticalFiles.isNotEmpty ? verticalFiles : files;

    candidateFiles.sort((a, b) {
      final wA = a.width ?? 0;
      final hA = a.height ?? 0;
      final wB = b.width ?? 0;
      final hB = b.height ?? 0;

      final distA = (wA - 540).abs() + (hA - 960).abs();
      final distB = (wB - 540).abs() + (hB - 960).abs();

      return distA.compareTo(distB);
    });

    return candidateFiles.first;
  }
}