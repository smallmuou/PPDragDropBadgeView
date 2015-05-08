/**
 * PPDragDropBadgeView.c
 *
 * A badge view with drag and drop.
 *
 * MIT licence follows:
 *
 * Copyright (C) 2015 Wenva <lvyexuwenfa100@126.com>
 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "PPDragDropBadgeView.h"
#import "PRTween.h"
#import "PRTweenTimingFunctions.h"

#define kDefaultTintColor               [UIColor redColor]
#define kDefaultBorderColor             [UIColor clearColor]
#define kDefaultBorderWidth             1.0f
#define kElasticDuration                0.5f
#define kFromRadiusScaleCoefficient     0.09f
#define kToRadiusScaleCoefficient       0.05f
#define kMaxDistanceScaleCoefficient    8.0f
#define kFollowTimeInterval             0.016f
#define kBombDuration                   0.5f
#define kValidRadius                    20.0f

CGFloat distanceBetweenPoints (CGPoint p1, CGPoint p2) {
    CGFloat deltaX = p2.x - p1.x;
    CGFloat deltaY = p2.y - p1.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
};

@interface PPDragDropBadgeView () {
    CGFloat                 _viscosity;
    
    CGPoint                 _originPoint;
    
    CGPoint                 _fromPoint;
    CGPoint                 _toPoint;
    CGFloat                 _fromRadius;
    CGFloat                 _toRadius;
    
    CGPoint                 _elasticBeginPoint;
    
    BOOL                    _missed;    //Missed focus
    BOOL                    _beEnableDragDrop;
    CGFloat                 _maxDistance;
    CGFloat                 _distance;
    PRTweenOperation*       _activeTweenOperation;
    
    UILabel*                _textLabel;
    UIImageView*            _bombImageView;
    
    UIPanGestureRecognizer* _panGestureRecognizer;
    UIView*                 _rootView;
    NSMutableArray*         _followPoints;
    NSTimer*                _followTimer;
}

@end


@implementation PPDragDropBadgeView

+ (NSString* )version {
    return @"1.1";
}

- (instancetype)initWithSuperView:(UIView* )superView
                         location:(CGPoint)location
                           radius:(CGFloat)radius
               dragdropCompletion:(void(^)())dragdropCompletion {
    
    UIView* rootView = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    self = [super initWithFrame:[superView convertRect:rootView.bounds fromView:rootView]];
    if (self) {
        //Init data
        _rootView = rootView;
        _borderColor = kDefaultBorderColor;
        _borderWidth = kDefaultBorderWidth;
        _tintColor = kDefaultTintColor;
        _location = location;
        _originPoint = [superView convertPoint:location toView:_rootView];
        _radius = radius;
        _followPoints = [NSMutableArray array];
        self.dragdropCompletion = dragdropCompletion;
        
        //Init self
        self.backgroundColor = [UIColor clearColor];
        
        //Init textLabel
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2*radius, 2*radius)];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureAction:)];
        [_rootView addGestureRecognizer:_panGestureRecognizer];
        
        //Init ImageView
        _bombImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        _bombImageView.animationImages = @[[UIImage imageNamed:@"PPDragDropBadgeView.bundle/bomb0"],
                                           [UIImage imageNamed:@"PPDragDropBadgeView.bundle/bomb1"],
                                           [UIImage imageNamed:@"PPDragDropBadgeView.bundle/bomb2"],
                                           [UIImage imageNamed:@"PPDragDropBadgeView.bundle/bomb3"],
                                           [UIImage imageNamed:@"PPDragDropBadgeView.bundle/bomb4"]];
        _bombImageView.animationRepeatCount = 1;
        _bombImageView.animationDuration = kBombDuration;
        [self addSubview:_bombImageView];
        
        [superView addSubview:self];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [self.superview convertRect:_rootView.bounds fromView:_rootView];
    _originPoint = [self.superview convertPoint:_location toView:_rootView];
    [self reset];
}

- (void)dealloc {
    [_rootView removeGestureRecognizer:_panGestureRecognizer];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    _maxDistance = kMaxDistanceScaleCoefficient*self.radius;
    _textLabel.frame = CGRectMake(0, 0, 2*radius, 2*radius);
    [self updateRadius];
}

- (void)setLocation:(CGPoint)location {
    _location = location;
    _originPoint = [self.superview convertPoint:location toView:_rootView];

    [self reset];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor?borderColor:kDefaultBorderColor;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor?tintColor:kDefaultTintColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    _textLabel.text = text;
    _textLabel.hidden = NO;
    [self reset];
}

- (void)reset {
    _fromPoint = _originPoint;
    _toPoint = _fromPoint;
    _maxDistance = kMaxDistanceScaleCoefficient*self.radius;

    [self updateRadius];
}

- (void)update:(PRTweenPeriod*)period {
    CGFloat c = period.tweenedValue;
    if (isnan(c) || c > 10000000.0f||c < -10000000.0f) return; //Fix Bug:有时会返回一个非常大的数值
    
    if (_missed) {
        CGFloat x = (_toPoint.x-_elasticBeginPoint.x)*c/_distance;
        CGFloat y = (_toPoint.y-_elasticBeginPoint.y)*c/_distance;
        
        _fromPoint = CGPointMake(_elasticBeginPoint.x+x, _elasticBeginPoint.y+y);
    } else {
        CGFloat x = (_fromPoint.x - _elasticBeginPoint.x)*c/_distance;
        CGFloat y = (_fromPoint.y - _elasticBeginPoint.y)*c/_distance;
        
        _toPoint = CGPointMake(_elasticBeginPoint.x+x, _elasticBeginPoint.y+y);
        
    }
    [self updateRadius];
}


- (void)updateRadius {
    CGFloat r = distanceBetweenPoints(_fromPoint, _toPoint);
    _fromRadius = self.radius-kFromRadiusScaleCoefficient*r;
    _toRadius = self.radius-kToRadiusScaleCoefficient*r;
    _viscosity = 1.0-r/_maxDistance;
    _textLabel.font = [UIFont systemFontOfSize:(2*_toRadius)/(1.2*[_textLabel.text length])];
    _textLabel.center = _toPoint;

    [self setNeedsDisplay];
}


- (UIBezierPath* )bezierPathWithFromPoint:(CGPoint)fromPoint
                                  toPoint:(CGPoint)toPoint
                               fromRadius:(CGFloat)fromRadius
                                 toRadius:(CGFloat)toRadius scale:(CGFloat)scale{
    
    if (isnan(fromRadius) || isnan(toRadius)||isnan(fromRadius)||isnan(toRadius)) return nil;

    UIBezierPath* path = [[UIBezierPath alloc] init];
    CGFloat r = distanceBetweenPoints(fromPoint, toPoint);
    CGFloat offsetY = fabs(fromRadius-toRadius);
    if (r <= offsetY) {
        CGPoint center;
        CGFloat radius;
        if (fromRadius >= toRadius) {
            center = fromPoint;
            radius = fromRadius;
        } else {
            center = toPoint;
            radius = toRadius;
        }
        [path addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    } else {
        CGFloat originX = toPoint.x - fromPoint.x;
        CGFloat originY = toPoint.y - fromPoint.y;
        
        CGFloat fromOriginAngel = (originX >= 0)?atan(originY/originX):(atan(originY/originX)+M_PI);
        CGFloat fromOffsetAngel = (fromRadius >= toRadius)?acos(offsetY/r):(M_PI-acos(offsetY/r));
        CGFloat fromStartAngel = fromOriginAngel + fromOffsetAngel;
        CGFloat fromEndAngel = fromOriginAngel - fromOffsetAngel;
        
        CGPoint fromStartPoint = CGPointMake(fromPoint.x+cos(fromStartAngel)*fromRadius, fromPoint.y+sin(fromStartAngel)*fromRadius);
        
        CGFloat toOriginAngel = (originX < 0)?atan(originY/originX):(atan(originY/originX)+M_PI);
        CGFloat toOffsetAngel = (fromRadius < toRadius)?acos(offsetY/r):(M_PI-acos(offsetY/r));
        CGFloat toStartAngel = toOriginAngel + toOffsetAngel;
        CGFloat toEndAngel = toOriginAngel - toOffsetAngel;
        CGPoint toStartPoint = CGPointMake(toPoint.x+cos(toStartAngel)*toRadius, toPoint.y+sin(toStartAngel)*toRadius);
        
        CGPoint middlePoint = CGPointMake(fromPoint.x+(toPoint.x-fromPoint.x)/2, fromPoint.y+(toPoint.y-fromPoint.y)/2);
        CGFloat middleRadius = (fromRadius+toRadius)/2;
        
        CGPoint fromControlPoint = CGPointMake(middlePoint.x+sin(fromOriginAngel)*middleRadius*scale, middlePoint.y-cos(fromOriginAngel)*middleRadius*scale);
        
        CGPoint toControlPoint = CGPointMake(middlePoint.x+sin(toOriginAngel)*middleRadius*scale, middlePoint.y-cos(toOriginAngel)*middleRadius*scale);
        
        [path moveToPoint:fromStartPoint];
        
        //绘制from弧形
        [path addArcWithCenter:fromPoint radius:fromRadius startAngle:fromStartAngel endAngle:fromEndAngel clockwise:YES];
        
        //绘制from到to之间的贝塞尔曲线
        if (r > (fromRadius+toRadius)) {
            [path addQuadCurveToPoint:toStartPoint controlPoint:fromControlPoint];
        }
        
        //绘制to弧形
        [path addArcWithCenter:toPoint radius:toRadius startAngle:toStartAngel endAngle:toEndAngel clockwise:YES];
        
        //绘制to到from之间的贝塞尔曲线
        if (r > (fromRadius+toRadius)) {
            [path addQuadCurveToPoint:fromStartPoint controlPoint:toControlPoint];
        }
    }
    
    [path closePath];
    
    return path;
}


- (void)drawRect:(CGRect)rect {
    UIBezierPath* path = [self bezierPathWithFromPoint:_fromPoint toPoint:_toPoint fromRadius:_fromRadius toRadius:_toRadius scale:_viscosity];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - Touch
- (void)onGestureAction:(UIPanGestureRecognizer* )gesture {
    CGPoint point = [gesture locationInView:self];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self touchesBegan:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self touchesEnded:point];
            break;
        case UIGestureRecognizerStateChanged:
            [self touchesMoved:point];
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(CGPoint)point {
    _missed = NO;
    _beEnableDragDrop = CGRectContainsPoint(CGRectMake(_fromPoint.x-kValidRadius, _fromPoint.y-kValidRadius, 2*kValidRadius, 2*kValidRadius), point);
}

- (void)touchesEnded:(CGPoint)point {
    if (!_beEnableDragDrop) return;
    if (!_missed) {
        _elasticBeginPoint = _toPoint;
        _distance = distanceBetweenPoints(_fromPoint, _toPoint);
        
        [[PRTween sharedInstance] removeTweenOperation:_activeTweenOperation];
        
        PRTweenPeriod *period = [PRTweenPeriod periodWithStartValue:0 endValue:_distance duration:kElasticDuration];
        _activeTweenOperation = [[PRTween sharedInstance] addTweenPeriod:period target:self selector:@selector(update:) timingFunction:&PRTweenTimingFunctionElasticOut];
    } else {
        [self followEnded];

        if (CGRectContainsPoint(CGRectMake(_originPoint.x-kValidRadius, _originPoint.y-kValidRadius, 2*kValidRadius, 2*kValidRadius), point)) {
            [self reset];
        } else {
            _bombImageView.center = _toPoint;
            _toRadius = 0;
            _fromRadius = 0;
            _textLabel.hidden = YES;
            [_bombImageView startAnimating];
            _activeTweenOperation.updateSelector = nil;
            [[PRTween sharedInstance] removeTweenOperation:_activeTweenOperation];
            
            if (self.dragdropCompletion) {
                self.dragdropCompletion();
            }
        }
        
        [self setNeedsDisplay];
    }
}

#pragma mark - follow
- (void)insertFollowPoint:(CGPoint )point {
    @synchronized(_followPoints) {
        [_followPoints addObject:[NSValue valueWithCGPoint:point]];
    }
}

- (CGPoint)removeFollowPoint {
    CGPoint point = CGPointZero;
    @synchronized(_followPoints) {
        if ([_followPoints count]) {
            point = [[_followPoints firstObject] CGPointValue];
            [_followPoints removeObjectAtIndex:0];
        }
    }
    
    return point;
}

- (void)removeAllFollowPoints {
    @synchronized(_followPoints) {
        [_followPoints removeAllObjects];
    }
}

- (void)followTimeout:(NSTimer* )timer {
    CGPoint point = [self removeFollowPoint];
    if (!CGPointEqualToPoint(point, CGPointZero)) {
        _fromPoint = _toPoint = point;
        [self updateRadius];
    }
}

- (void)followEnded {
    [_followTimer invalidate];
    _followTimer = nil;
    [self removeAllFollowPoints];
}

- (void)touchesMoved:(CGPoint)point {
    if (!_beEnableDragDrop) return;
    
    CGFloat r = distanceBetweenPoints(_fromPoint, point);
    if (_missed) {
        _activeTweenOperation.updateSelector = nil;
        [self insertFollowPoint:point];
        
        if (!_followTimer) {
            _followTimer = [NSTimer scheduledTimerWithTimeInterval:kFollowTimeInterval target:self selector:@selector(followTimeout:) userInfo:nil repeats:YES];
        }
    } else {
        _toPoint = point;
        if (r > _maxDistance) {
            _missed = YES;
            _elasticBeginPoint = _fromPoint;
            _distance = distanceBetweenPoints(_fromPoint, _toPoint);
            
            [[PRTween sharedInstance] removeTweenOperation:_activeTweenOperation];
            
            PRTweenPeriod *period = [PRTweenPeriod periodWithStartValue:0 endValue:_distance duration:kElasticDuration];
            _activeTweenOperation = [[PRTween sharedInstance] addTweenPeriod:period target:self selector:@selector(update:) timingFunction:&PRTweenTimingFunctionElasticOut];
        } else {
            [self updateRadius];
        }
    }
    
}

@end
