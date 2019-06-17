//
//  DataListObject.m
//  WWCollectionWaterfallLayout
//
//  Created by YU on 11/6/2019.
//  Copyright © 2019 Tidus. All rights reserved.
//

#import "DataListObject.h"

@implementation DataListObject

@synthesize fromurl;//图片网址
@synthesize title;//图片标题
@synthesize content_sign;
@synthesize obj_url;
@synthesize small_url;
@synthesize mid_url;
@synthesize albumNum;
@synthesize dataId;
@synthesize image_width;
@synthesize image_height;
@synthesize mid_height;
@synthesize mid_width;
@synthesize set_id;
@synthesize small_height;
@synthesize small_width;

+(DataListObject *)buildWithtitle:(NSString *)title
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
{
    //NSLog(@"这里执行了");
    DataListObject * obj = [[DataListObject alloc] init];
    obj.title = title;
    obj.fromurl = f_u;
    obj.content_sign = c_s;
    obj.obj_url = o_u;
    obj.small_url = s_u;
    obj.mid_url = m_u;
    obj.albumNum = album_num;
    obj.dataId = data_id;
    obj.image_width = image_wid;
    obj.image_height = image_hei;
    obj.mid_height = mid_hei;
    obj.mid_width = mid_wid;
    obj.set_id = set_id;
    obj.small_height = small_hei;
    obj.small_width = small_wid;
    //NSLog(@"构造函数执行完了，img高度为：%d实际上应该为：%d",obj.image_height,image_hei);
    //NSLog(@"这里也执行了");
    return obj;
}


@end
