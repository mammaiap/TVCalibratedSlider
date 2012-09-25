//
//  TVSlider.m
//
//  Created by TavisacaIos on 9/4/12.
//  Copyright (c) 2012 Tavisca. All rights reserved.
//

#import "TVSlider.h"

@interface TVSlider () {
    UIImage *_thumbImage;
    CGPoint  _offset;
    UIColor *_highlightedStateTextColor;
    UIFont  *_highlightedStateTextFont;
    CGPoint highlightedStateTextPosition;
    BOOL isHighlightedStateTextPositionCustom;
}
@end

@implementation TVSlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _highlightedStateTextColor = [UIColor whiteColor];
        _highlightedStateTextFont = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSString *value = [NSString stringWithFormat:@"%0.0f",self.value];
    if(_thumbImage == nil){
        return;
    }
    UIGraphicsBeginImageContextWithOptions(_thumbImage.size, NO, 0);
    [_thumbImage drawAtPoint:CGPointMake(0, 0)];
    [_highlightedStateTextColor set];
    CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:16]];
    if(!isHighlightedStateTextPositionCustom){
        highlightedStateTextPosition = CGPointMake(_thumbImage.size.width/2 - size.width/2, 0);
    }
    [value drawAtPoint:highlightedStateTextPosition withFont:_highlightedStateTextFont];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbImage:image forState:UIControlStateHighlighted];
    UIGraphicsEndImageContext();
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGRect rectForThumbImage = [super thumbRectForBounds:bounds trackRect:rect value:value];
    if( self.state == UIControlStateHighlighted ) {
      rectForThumbImage = CGRectOffset(rectForThumbImage, _offset.x , _offset.y);
    }
    [self setNeedsDisplayInRect:rectForThumbImage];
    return rectForThumbImage;
}

- (void)setThumbImage:(UIImage *)thumbImage forState:(UIControlState)state withOffsetRelativeToCenterOfTrack:(CGPoint)offset {
    [super setThumbImage:thumbImage forState:state];
    if(state == UIControlStateHighlighted) {
        _thumbImage = thumbImage;
        _offset = offset;
    }
}

- (void)setTextColorForHighlightedState:(UIColor *)color {
    _highlightedStateTextColor = color;
}

- (void)setTextPositionForHighlightedStateRelativeToThumbImage:(CGPoint)position {
    isHighlightedStateTextPositionCustom = YES;
    highlightedStateTextPosition = position;
}

-(void)setTextFontForHighlightedState:(UIFont *)font {
    _highlightedStateTextFont = font;
}

@end