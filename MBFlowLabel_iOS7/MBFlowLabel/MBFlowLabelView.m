//
//  MBFlowLabelView.m
//  MBFlowLabel
//
//  Created by MB KWON on 2013. 12. 24..
//  Copyright (c) 2013년 MB KWON. All rights reserved.
//
//The MIT License (MIT)
//
//Copyright (c) 2013 Moonbeom Kyle KWON
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "MBFlowLabelView.h"

@interface MBFlowLabelView ()

@property (assign, nonatomic) NSInteger itemCount;
@property (assign, nonatomic) NSInteger contentOffset;

@property (assign, nonatomic) CGSize textLabelSize;
@property (strong, nonatomic) NSMutableArray *textLabelArray;
@property (strong, nonatomic) NSTimer *flowTimer;

@end

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
    [self relayoutTextLabel];
}

- (void)relayoutTextLabel {
    
    self.contentOffset = 0;
    self.itemCount = 0;
    
    if (self.flowTimer) {
        [self.flowTimer invalidate];
        self.flowTimer = nil;
    }
    
    if ([self getTextSize].width > self.frame.size.width) {
        
        [self setLabel];
        [self setClipsToBounds:YES];
        
        self.flowTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollingFlowText) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.flowTimer forMode:NSRunLoopCommonModes];
        
    } else {
        
        UILabel *staticLabel = [[UILabel alloc] init];
        if (_text) {
            [staticLabel setText:_text];
        } else if (_attributedText) {
            [staticLabel setAttributedText:_attributedText];
        } else {
            [staticLabel setText:nil];
            [staticLabel setAttributedText:nil];
        }
        
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
    if (_text) {
        UILabel *flowLabel = [[UILabel alloc] init];
        return [self.text sizeWithAttributes:@{NSFontAttributeName:flowLabel.font}];
    } else if (_attributedText) {
        return _attributedText.size;
    }
    
    return CGSizeZero;
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
                    [flowLabel setFrame:CGRectMake(0, 0,
                                                   floor(self.textLabelSize.width),
                                                   self.frame.size.height)];
                    break;
                    
                case 1:
                    [flowLabel setFrame:CGRectMake(floor(self.textLabelSize.width), 0,
                                                   floor(self.textLabelSize.width),
                                                   self.frame.size.height)];
                    break;
                    
                default:
                    break;
            }
            
            if (_text) {
                [flowLabel setText:_text];
            } else if (_attributedText) {
                [flowLabel setAttributedText:_attributedText];
            } else {
                [flowLabel setText:nil];
                [flowLabel setAttributedText:nil];
            }
            
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

-(void)setText:(NSString *)text {
    _attributedText = nil;
    for (UILabel * label in self.textLabelArray) {
        label.text = text;
    }
    [self relayoutTextLabel];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    _text = nil;
    for (UILabel * label in self.textLabelArray) {
        label.attributedText = attributedText;
    }
    [self relayoutTextLabel];
}

-(void)setFont:(UIFont *)font {
    for (UILabel * label in self.textLabelArray) {
        label.font = font;
    }
}

-(void)setTextColor:(UIColor *)textColor {
    for (UILabel * label in self.textLabelArray) {
        label.textColor = textColor;
    }
}

@end
