const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#010000", /* black   */
  [1] = "#9D586A", /* red     */
  [2] = "#938771", /* green   */
  [3] = "#BE6C80", /* yellow  */
  [4] = "#CE768B", /* blue    */
  [5] = "#E17E97", /* magenta */
  [6] = "#BFAD8C", /* cyan    */
  [7] = "#dcbfbd", /* white   */

  /* 8 bright colors */
  [8]  = "#9a8584",  /* black   */
  [9]  = "#9D586A",  /* red     */
  [10] = "#938771", /* green   */
  [11] = "#BE6C80", /* yellow  */
  [12] = "#CE768B", /* blue    */
  [13] = "#E17E97", /* magenta */
  [14] = "#BFAD8C", /* cyan    */
  [15] = "#dcbfbd", /* white   */

  /* special colors */
  [256] = "#010000", /* background */
  [257] = "#dcbfbd", /* foreground */
  [258] = "#dcbfbd",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
