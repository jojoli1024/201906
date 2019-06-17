//
//  DataListObject.h
//  WWCollectionWaterfallLayout
//
//  Created by YU on 11/6/2019.
//  Copyright © 2019 Tidus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataListObject : NSObject

@property(nonatomic,strong)NSString * fromurl;
@property(nonatomic,strong)NSString * title;//图片标题
@property(nonatomic,strong)NSString * content_sign;
@property(nonatomic,strong)NSString * obj_url;
@property(nonatomic,strong)NSMutableString * small_url;
@property(nonatomic,strong)NSString * mid_url;
@property(nonatomic)NSInteger albumNum;
@property(nonatomic)NSInteger dataId;
@property(nonatomic)NSInteger image_width;
@property(nonatomic)NSInteger image_height;
@property(nonatomic)NSInteger mid_height;
@property(nonatomic)NSInteger mid_width;
@property(nonatomic)NSInteger set_id;
@property(nonatomic)NSInteger small_height;
@property(nonatomic)NSInteger small_width;

+(DataListObject*)buildWithtitle:(NSString *)title
                    Fromurl:(NSString *)f_u
               Content_sign:(NSString *)c_s
                    Obj_url:(NSString *)o_u
                  Small_url:(NSString *)s_u
                    Mid_url:(NSString *)m_u
                   AlbumNum:(NSInteger)album_num
                     DataId:(NSInteger)data_id
                Image_width:(NSInteger)image_wid
               Image_height:(NSInteger)image_hei
                 Mid_height:(NSInteger)mid_hei
                  Mid_width:(NSInteger)mid_wid
                     Set_id:(NSInteger)set_id
               Small_height:(NSInteger)small_hei
                Small_width:(NSInteger)small_wid
;

@end

NS_ASSUME_NONNULL_END
