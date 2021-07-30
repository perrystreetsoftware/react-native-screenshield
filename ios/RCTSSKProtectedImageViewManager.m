//
//  Copyright © 2019 Confide. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE SCREENSHIELDKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPROUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "RCTSSKProtectedImageViewManager.h"
#import <SDWebImage/SDWebImage.h>

@import ScreenShieldKit;

@implementation RCTSSKProtectedImageViewManager

RCT_EXPORT_MODULE()

RCT_CUSTOM_VIEW_PROPERTY(image, UIImage, SSKProtectedImageView) {
  if (json) {
      NSString *uri = json[@"uri"];
      NSURL *URL = [NSURL URLWithString:uri];
      SDWebImageManager *manager = [SDWebImageManager sharedManager];
      [manager loadImageWithURL:URL options:(SDWebImageLowPriority | SDWebImageRetryFailed)
                       progress:nil
                      completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
          dispatch_async(dispatch_get_main_queue(), ^{
              [view setImage:image];
          });
      }];
  } else {
    [view setImage:nil];
  }
}

- (UIView *)view {
  return [[SSKProtectedImageView alloc] initWithImage:nil];
}

@end
