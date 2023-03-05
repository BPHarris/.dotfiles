/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#080808", /* black   */
  [1] = "#cf4f43", /* red     */
  [2] = "#54964f", /* green   */
  [3] = "#d17536", /* yellow  */
  [4] = "#1b4666", /* blue    */
  [5] = "#5e196d", /* magenta */
  [6] = "#5e8b8d", /* cyan    */
  [7] = "#646464", /* white   */

  /* 8 bright colors */
  [8]  = "#323232", /* black   */
  [9]  = "#993e36", /* red     */
  [10] = "#5c8b59", /* green   */
  [11] = "#aa9c30", /* yellow  */
  [12] = "#1267a5", /* blue    */
  [13] = "#8910ad", /* magenta */
  [14] = "#61c4c6", /* cyan    */
  [15] = "#e0e0e0", /* white   */

  /* special colors */
  [256] = "#202020", /* background */
  [257] = "#f5f5f5", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;
