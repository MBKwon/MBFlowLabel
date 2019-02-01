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
            [staticLabel setFont:_font];
            [staticLabel setText:_text];
            [staticLabel setTextColor:_textColor];
        } else if (_attributedText) {
            [staticLabel setAttributedText:_attributedText];
        } else {
            [staticLabel setFont:nil];
            [staticLabel setText:nil];
            [staticLabel setTextColor:nil];
            [staticLabel setAttributedText:nil];
        }
        
        [staticLabel setTextAlignment:NSTextAlignmentCenter];
        [staticLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:staticLabel];
    }
}

-(void)scrollingFlowText
{
    double labelWidth = ceil(self.textLabelSize.width);
    
    if (labelWidth <= -(self.contentOffset)) {
        UILabel *tempLabel = [self getLabel];
        [tempLabel setFrame:CGRectMake(labelWidth, 0, labelWidth, self.frame.size.height)];
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
        if (_font) {
            return [self.text sizeWithAttributes:@{NSFontAttributeName:_font}];
        } else {
            UILabel *flowLabel = [[UILabel alloc] init];
            return [self.text sizeWithAttributes:@{NSFontAttributeName:flowLabel.font}];
        }
    } else if (_attributedText) {
        return _attributedText.size;
    }
    
    return CGSizeZero;
}

-(void)setLabel
{
    if (self.textLabelArray == nil) {
        
        self.textLabelArray = [NSMutableArray new];
        UILabel *flowLabel;
        
        for (int i =0; i<2; i++) {
            
            flowLabel = [[UILabel alloc] init];
            [self addSubview:flowLabel];
            [self.textLabelArray addObject:flowLabel];
            
            self.textLabelSize = [self getTextSize];
            switch (i) {
                case 0:
                    [flowLabel setFrame:CGRectMake(0, 0,
                                                   ceil(self.textLabelSize.width),
                                                   self.frame.size.height)];
                    break;
                    
                case 1:
                    [flowLabel setFrame:CGRectMake(ceil(self.textLabelSize.width), 0,
                                                   ceil(self.textLabelSize.width),
                                                   self.frame.size.height)];
                    break;
                    
                default:
                    break;
            }
            
            if (_text) {
                [flowLabel setFont:_font];
                [flowLabel setText:_text];
                [flowLabel setTextColor:_textColor];
            } else if (_attributedText) {
                [flowLabel setAttributedText:_attributedText];
            } else {
                [flowLabel setFont:nil];
                [flowLabel setText:nil];
                [flowLabel setTextColor:nil];
                [flowLabel setAttributedText:nil];
            }
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
    _text = text;
    _attributedText = nil;
    for (UILabel * label in self.textLabelArray) {
        label.text = text;
    }
    [self relayoutTextLabel];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    _text = nil;
    _attributedText = attributedText;
    for (UILabel * label in self.textLabelArray) {
        label.attributedText = attributedText;
    }
    [self relayoutTextLabel];
}

-(void)setFont:(UIFont *)font {
    _font = font;
    for (UILabel * label in self.textLabelArray) {
        label.font = font;
    }
}

-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (UILabel * label in self.textLabelArray) {
        label.textColor = textColor;
    }
}

@end
