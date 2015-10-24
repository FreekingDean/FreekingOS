char *fb = (char *) 0x000B8000;
char FB_GREEN = (char) 0x02;
char FB_DARK_GREY = (char) 0x08;

/** fb_write_cell:
 *  Writes a character with the given foreground and background to position i
 *  in the framebuffer.
 *
 *  @param i  The location in the framebuffer
 *  @param c  The character
 *  @param fg The foreground color
 *  @param bg The background color
 */
void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg)
{
  i *= 2;
  fb[i] = c;
  fb[i + 1] = ((fg & 0x0F) << 4) | (bg & 0x0F);
}

int sum_of_three(int arg1, int arg2, int arg3)
{
  fb_write_cell(0, 0, FB_GREEN, FB_DARK_GREY);
  fb_write_cell(1, 0, FB_GREEN, FB_DARK_GREY);
  return arg2 * arg2 + arg1 + arg3;
}

