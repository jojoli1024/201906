//
//  MyTableCell.m
//  ExperimentWeek
//
//  Created by jojo Li on 17/6/2019.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "MyTableCell.h"

@implementation MyTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 2;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
