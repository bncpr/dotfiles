return {
  s("dnlgerr", fmt('CHEETAH_LOG(DN_LOG_ERR, "{1}")', i(1, "err_msg"))),
  s("dnlgdbg", fmt('CHEETAH_LOG(DN_LOG_DEBUG, "{1}")', i(1, "debug_msg"))),
  s("dnlgtrc", fmt('CHEETAH_LOG(DN_LOG_INFO, "{1}")', i(1, "trace_msg"))),
}
