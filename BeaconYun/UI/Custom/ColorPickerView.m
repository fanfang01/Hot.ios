//
//  ColorPickerView.m
//  BeaconYun
//
//  Created by SACRELEE on 4/26/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import "ColorPickerView.h"
#import <Masonry.h>

#define selfSize self.bounds.size

@implementation ColorPickerView {
    UIImageView *_imageView;
    UIView *_colorLayer;
    UIView *_movingLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)initView {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self layoutIfNeeded];
    
    _imageView = [[UIImageView alloc]init];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _imageView.image = [UIImage imageNamed:@"colors.jpg"];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = selfSize.width / 2.f;
    
    UIView *view = [[UIView alloc]init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 60, 60));
        make.center.equalTo(self);
    }];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 30.f;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake( 0, 0);
    view.layer.shadowOpacity = 1;
    
    _colorLayer = [[UIView alloc]init];
    [view addSubview:_colorLayer];
    [_colorLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 45, 45));
        make.center.equalTo(view);
    }];
    _colorLayer.layer.cornerRadius = 22.5f;
    _colorLayer.layer.masksToBounds = YES;
    _colorLayer.backgroundColor = [UIColor redColor];
    
    _movingLayer = [[UIView alloc]init];
    [self addSubview:_movingLayer];
    [_movingLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( 35.f, 35.f));
        make.right.equalTo(_imageView).offset(-5);
        make.top.equalTo(_imageView).offset((selfSize.height - 35) / 2.0f);
    }];
    _movingLayer.backgroundColor = [UIColor whiteColor];
    _movingLayer.alpha = 0.7;
    _movingLayer.layer.cornerRadius = 17.5;
    _movingLayer.layer.shadowColor = [UIColor blackColor].CGColor;
    _movingLayer.layer.shadowOpacity = 1.f;
    _movingLayer.layer.shadowOffset = CGSizeMake( 0, 0);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self initView];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark *****************************Handler
- (void)handleTouch:(UITouch *)touch withStatus:(BOOL)end
{
    CGPoint point = [touch locationInView:_imageView];
    
    CGFloat halfx = selfSize.width / 2.f;
    
    CGFloat dx = point.x - halfx;
    CGFloat dy = point.y - halfx;
    
    if (sqrt(dx*dx + dy* dy) > halfx)
        return ;

    _movingLayer.frame = CGRectMake( point.x - 17.5f, point.y - 17.5f, 35.f, 35.f);
    _colorLayer.backgroundColor = [self colorAtx:point.x y:point.y image:_imageView.image];
    
    if (end && _completionBlock) {
        
        CGFloat r = 0.0;
        CGFloat g = 0.0;
        CGFloat b = 0.0;
        CGFloat a = 0.0;
        
        [_colorLayer.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
        _completionBlock([NSString stringWithFormat:@"%.2x%.2x%.2x", (unsigned int)(r * 255), (unsigned int)(g * 255), (unsigned int)(b * 255)]);
    }
}

- (UIColor *)colorAtx:(CGFloat) x y:(CGFloat)y image:(UIImage *)image
{
    CGPoint p = [self convertPoint:CGPointMake(x, y) fromImageView:_imageView];

    return [self pickColorWithPoint:p fromImage:image];
}

- (UIColor *)pickColorWithPoint:(CGPoint)point fromImage:(UIImage *)image
{
    UIColor* color = nil;
    
    CGImageRef cgImage =  image.CGImage;
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    NSUInteger x = (NSUInteger)floor(point.x) * image.scale;
    NSUInteger y = (NSUInteger)floor(point.y) * image.scale;
    
    if ((x < width) && (y < height)) {
        CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
        CFDataRef bitmapData = CGDataProviderCopyData(provider);
        
        const UInt8 *data = CFDataGetBytePtr(bitmapData);
        
        size_t offset = ((width * y) + x) * 4;
        
        UInt8 red   = data[offset];
        UInt8 green = data[offset + 1];
        UInt8 blue  = data[offset + 2];
        UInt8 alpha = data[offset + 3];
        
        CFRelease(bitmapData);
        
        color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
    }
    
    return color;
}

- (CGPoint)convertPoint:(CGPoint)viewPoint fromImageView:(UIImageView *)imageView
{
    CGPoint imagePoint = viewPoint;

    CGSize imageSize = imageView.image.size;
    CGSize viewSize  = imageView.bounds.size;
    
    CGFloat ratioX = viewSize.width / imageSize.width;
    CGFloat ratioY = viewSize.height / imageSize.height;
    
    UIViewContentMode contentMode = imageView.contentMode;
    
    switch (contentMode) {
        case UIViewContentModeScaleToFill:
        case UIViewContentModeRedraw:
        {
            imagePoint.x /= ratioX;
            imagePoint.y /= ratioY;
            break;
        }
            
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat scale;
            
            if (contentMode == UIViewContentModeScaleAspectFit) {
                scale = MIN(ratioX, ratioY);
            }
            else /*if (contentMode == UIViewContentModeScaleAspectFill)*/ {
                scale = MAX(ratioX, ratioY);
            }
            
            // Remove the x or y margin added in FitMode
            imagePoint.x -= (viewSize.width  - imageSize.width  * scale) / 2.0f;
            imagePoint.y -= (viewSize.height - imageSize.height * scale) / 2.0f;
            
            imagePoint.x /= scale;
            imagePoint.y /= scale;
            
            break;
        }
            
        case UIViewContentModeCenter:
        {
            imagePoint.x -= (viewSize.width - imageSize.width)  / 2.0f;
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0f;
            
            break;
        }
            
        case UIViewContentModeTop:
        {
            imagePoint.x -= (viewSize.width - imageSize.width)  / 2.0f;
            
            break;
        }
            
        case UIViewContentModeBottom:
        {
            imagePoint.x -= (viewSize.width - imageSize.width)  / 2.0f;
            imagePoint.y -= (viewSize.height - imageSize.height);
            
            break;
        }
            
        case UIViewContentModeLeft:
        {
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0f;
            
            break;
        }
            
        case UIViewContentModeRight:
        {
            imagePoint.x -= (viewSize.width - imageSize.width);
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0f;
            
            break;
        }
            
        case UIViewContentModeTopRight:
        {
            imagePoint.x -= (viewSize.width - imageSize.width);
            
            break;
        }
            
            
        case UIViewContentModeBottomLeft:
        {
            imagePoint.y -= (viewSize.height - imageSize.height);
            
            break;
        }
            
            
        case UIViewContentModeBottomRight:
        {
            imagePoint.x -= (viewSize.width - imageSize.width);
            imagePoint.y -= (viewSize.height - imageSize.height);
            
            break;
        }
            
        case UIViewContentModeTopLeft:
        default:
        {
            break;
        }
    }
    
    return imagePoint;
}


#pragma mark *****************************Touch Delegates
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:(UITouch *)[touches anyObject] withStatus:NO];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:(UITouch *)[touches anyObject] withStatus:NO];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:(UITouch *)[touches anyObject] withStatus:YES];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self handleTouch:(UITouch *)[touches anyObject] withStatus:YES];
}





@end
