//
//  MBFlowLabelView.m
//  MBFlowLabel
//
//  Created by MB KWON on 2013. 12. 24..
//  Copyright (c) 2013년 MB KWON. All rights reserved.
//

#import "MBFlowLabelView.h"

@implementation MBFlowLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (self.backgroundColor == nil) {
            [self setBackgroundColor:[UIColor clearColor]];
        }
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    self.contentOffset = 0;
    self.itemCount = 0;
    if ([self getTextSize].width > self.frame.size.width) {
        
        [self setLabel];
        [self setClipsToBounds:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollingFlowText) userInfo:nil repeats:YES];
    } else {
        
        UILabel *staticLabel = [[UILabel alloc] init];
        [staticLabel setText:self.text];
        [staticLabel setTextAlignment:NSTextAlignmentCenter];
        [staticLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:staticLabel];
    }
    
}

-(void)scrollingFlowText
{
    int width = (int) self.textLabelSize.width;
    
    if (width <= -(self.contentOffset)) {
        UILabel *tempLabel = [self getLabel];
        [tempLabel setFrame:CGRectMake(self.textLabelSize.width, 0, self.textLabelSize.width, self.frame.size.height)];
    }
    
    UILabel *tempLabel = [self.textLabelArray objectAtIndex:(self.itemCount)%2];
    self.contentOffset = tempLabel.frame.origin.x;
    
    for (UILabel *tempLabel in self.textLabelArray) {
        [UIView animateWithDuration:0.1 animations:^ {
            
            CGRect currentRect = [tempLabel frame];
            currentRect.origin.x--;
            [tempLabel setFrame:currentRect];
        }];
    }
}

-(CGSize)getTextSize
{
    UILabel *flowLabel = [[UILabel alloc] init];
    return [self.text sizeWithAttributes:@{NSFontAttributeName:flowLabel.font}];
}

-(void)setLabel
{
    if (self.textLabelArray == nil) {
        
        self.textLabelArray = [NSMutableArray new];
        
        for (int i =0; i<2; i++) {
            
            UILabel *flowLabel = [[UILabel alloc] init];
            self.textLabelSize = [self.text sizeWithAttributes:@{NSFontAttributeName:flowLabel.font}];
            
            switch (i) {
                case 0:
                    [flowLabel setFrame:CGRectMake(0, 0, self.textLabelSize.width, self.frame.size.height)];
                    break;
                    
                case 1:
                    [flowLabel setFrame:CGRectMake(self.textLabelSize.width, 0, self.textLabelSize.width, self.frame.size.height)];
                    break;
                    
                default:
                    break;
            }
            [flowLabel setText:self.text];
            
            [self addSubview:flowLabel];
            [self.textLabelArray addObject:flowLabel];
        }
    }
}

-(UILabel *)getLabel
{
    if (self.textLabelArray != nil) {
        
        UILabel *tempLabel = [self.textLabelArray objectAtIndex:(self.itemCount++)%2];
        return tempLabel;
        
    } else {
        return nil;
    }
}

@end
