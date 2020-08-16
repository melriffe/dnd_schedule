#include "dnd_schedule.h"

VALUE rb_mDndSchedule;

void
Init_dnd_schedule(void)
{
  rb_mDndSchedule = rb_define_module("DndSchedule");
}
