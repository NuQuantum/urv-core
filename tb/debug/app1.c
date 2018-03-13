int main(void)
{
  puts("Hello world\n");
  asm volatile("ebreak");
  return 0;
}
