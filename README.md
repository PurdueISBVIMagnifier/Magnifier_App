# Magnifier_App
App designed for students that are visually impaired to see their work better

After installing the pods go to Pods, then MaterialControls, then MDRippleLayer.m and replace lines 126-137 with the following code:
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  if (flag) {
    if (_userIsHolding) {
      _effectIsRunning = false;
        if (self.delegate && [self.delegate respondsToSelector:@selector(mdLayer:didFinishEffect:)]) {
            [(id<MDLayerDelegate>) self.delegate mdLayer:self didFinishEffect:anim.duration];
        }
    } else {
      [self clearEffects];
    }
  }
}


