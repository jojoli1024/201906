//
//  imageChangeSize.h
//  ExperimentWeek
//
//  Created by jojo Li on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface imageChangeSize : NSObject
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
