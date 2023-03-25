delayedFunction({Function? setstatefn, int? durationmilliseconds}) {
  Future.delayed(Duration(milliseconds: durationmilliseconds ?? 2000), () {
// Here you can write your code

    setstatefn!();
  });
}
