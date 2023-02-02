return {
  s("dnlgerr", fmt('CHEETAH_LOG(DN_LOG_ERR, "{1}");', i(1, "err_msg"))),
  s("dnlgdbg", fmt('CHEETAH_LOG(DN_LOG_DEBUG, "{1}");', i(1, "debug_msg"))),
  s("dnlgtrc", fmt('CHEETAH_LOG(DN_LOG_INFO, "{1}");', i(1, "trace_msg"))),
  s("qmkcomb", fmt("COMB({1}, {2}, {3})", {i(1, "name"), i(2, "result"), i(3, "combo")})),
  s("qmksubs", fmt('SUBS({1}, "{2}"{3}, {4})', {i(1, "name"), i(2, "result"), i(3, "rest of string"), i(4, "combo")})),
}
