//
//  MBFlowLabelView.h
//  MBFlowLabel
//
//  Created by MB KWON on 2013. 12. 24..
//  Copyright (c) 2013년 MB KWON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBFlowLabelView : UIView

@property (assign, nonatomic) NSInteger itemCount;
@property (assign, nonatomic) NSInteger contentOffset;


@property (assign, nonatomic) CGSize textLabelSize;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSMutableArray *textLabelArray;

@end
