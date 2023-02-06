import 'package:DART_PACKAGE_NAME/common/constant/app_images.dart';
import 'package:flutter/widgets.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class ImagePrecacheState extends HasInitialized {
  const ImagePrecacheState({required super.isInitialized});
}

ImagePrecacheState useImagePrecacheState() {
  final context = useContext();

  final state = useAutoComputedState(
    compute: () async =>
        Future.wait([for (final image in AppImages.precached) precacheImage(AssetImage(image), context)]),
    keys: [],
  );

  return ImagePrecacheState(isInitialized: state.value is ComputedStateValueReady);
}
