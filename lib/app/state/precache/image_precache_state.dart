import 'package:DART_PACKAGE_NAME/common/constant/app_images.dart';
import 'package:flutter/widgets.dart';
import 'package:utopia_arch/utopia_arch.dart';

class ImagePrecacheState extends HasInitialized {
  const ImagePrecacheState({required super.isInitialized});
}

ImagePrecacheState useImagePrecacheState() {
  final context = useBuildContext();

  final state = useAutoComputedState(
    () async => Future.wait([
      for (final image in AppImages.precached) precacheImage(AssetImage(image), context),
    ]),
  );

  return ImagePrecacheState(isInitialized: state.value is ComputedStateValueReady);
}
