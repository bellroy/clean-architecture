# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/rb-readline/all/rb-readline.rbi
#
# rb-readline-0.5.5

module RbReadline
  def __rl_fix_point(x); end
  def _extract_last_quote(string, quote_char); end
  def _rl_abort_internal; end
  def _rl_adjust_point(string, point); end
  def _rl_any_typein; end
  def _rl_arg_dispatch(cxt, c); end
  def _rl_arg_getchar; end
  def _rl_arg_init; end
  def _rl_arg_overflow; end
  def _rl_backspace(count); end
  def _rl_bind_tty_special_chars(kmap); end
  def _rl_char_search(count, fdir, bdir); end
  def _rl_char_search_internal(count, dir, smbchar, len); end
  def _rl_char_value(buf, ind); end
  def _rl_clean_up_for_exit; end
  def _rl_clear_screen; end
  def _rl_clear_to_eol(count); end
  def _rl_col_width(string, start, _end); end
  def _rl_compare_chars(buf1, pos1, buf2, pos2); end
  def _rl_control_keypad(on); end
  def _rl_copy_to_kill_ring(text, append); end
  def _rl_current_display_line; end
  def _rl_dispatch(key, map); end
  def _rl_dispatch_subseq(key, map, got_subseq); end
  def _rl_enable_meta_key; end
  def _rl_erase_at_end_of_line(l); end
  def _rl_erase_entire_line; end
  def _rl_find_completion_word; end
  def _rl_find_next_mbchar(string, seed, count, flags); end
  def _rl_find_prev_mbchar(string, seed, flags); end
  def _rl_fix_point(fix_mark_too); end
  def _rl_get_char_len(src); end
  def _rl_get_screen_size(tty, ignore_env); end
  def _rl_history_set_point; end
  def _rl_init_eightbit; end
  def _rl_init_line_state; end
  def _rl_init_terminal_io(terminal_name); end
  def _rl_input_available; end
  def _rl_insert_char(count, c); end
  def _rl_insert_next(count); end
  def _rl_insert_typein(c); end
  def _rl_internal_char_cleanup; end
  def _rl_internal_pager(lines); end
  def _rl_is_mbchar_matched(string, seed, _end, mbchar, length); end
  def _rl_isearch_cleanup(cxt, r); end
  def _rl_isearch_dispatch(cxt, c); end
  def _rl_isearch_fini(cxt); end
  def _rl_isearch_init(direction); end
  def _rl_make_prompt_for_search(pchar); end
  def _rl_move_cursor_relative(new, data, start = nil); end
  def _rl_move_vert(to); end
  def _rl_nsearch_abort(cxt); end
  def _rl_nsearch_cleanup(cxt, r); end
  def _rl_nsearch_dispatch(cxt, c); end
  def _rl_nsearch_dosearch(cxt); end
  def _rl_nsearch_init(dir, pchar); end
  def _rl_output_some_chars(string, start, count); end
  def _rl_overwrite_char(count, c); end
  def _rl_overwrite_rubout(count, key); end
  def _rl_read_init_file(filename, include_level); end
  def _rl_read_mbchar(mbchar, size); end
  def _rl_read_mbstring(first, mb, mlen); end
  def _rl_redisplay_after_sigwinch; end
  def _rl_replace_text(text, start, _end); end
  def _rl_reset_argument; end
  def _rl_rubout_char(count, key); end
  def _rl_scxt_alloc(type, flags); end
  def _rl_search_getchar(cxt); end
  def _rl_set_insert_mode(im, force); end
  def _rl_set_mark_at_pos(position); end
  def _rl_start_using_history; end
  def _rl_strip_prompt(pmt); end
  def _rl_subseq_getchar(key); end
  def _rl_to_lower(char); end
  def _rl_unget_char(key); end
  def _rl_update_final; end
  def _rl_vi_done_inserting; end
  def _rl_vi_initialize_line; end
  def _rl_vi_reset_last; end
  def _rl_vi_save_insert(up); end
  def _rl_vi_textmod_command(c); end
  def _rl_walphabetic(c); end
  def add_history(string); end
  def alloc_history_entry(string, ts); end
  def alloc_undo_entry(what, start, _end, text); end
  def append_to_match(text, delimiter, quote_char, nontrivial_match); end
  def bind_arrow_keys; end
  def bind_arrow_keys_internal(map); end
  def bind_termcap_arrow_keys(map); end
  def block_sigint; end
  def clear_history; end
  def compute_lcd_of_matches(match_list, matches, text); end
  def cr; end
  def cr_faster(new, cur); end
  def ctrl_char(c); end
  def current_history; end
  def delete_chars(count); end
  def display_matches(matches); end
  def endsrch_char(c); end
  def expand_prompt(pmt); end
  def fnprint(to_print); end
  def fnwidth(string); end
  def gen_completion_matches(text, start, _end, our_func, found_quote, quote_char); end
  def get_term_capabilities(buffer); end
  def get_y_or_n(for_pager); end
  def handle_parser_directive(statement); end
  def hist_inittime; end
  def history_arg_extract(first, last, string); end
  def history_base; end
  def history_base=(arg0); end
  def history_get(offset); end
  def history_is_stifled; end
  def history_length; end
  def history_length=(arg0); end
  def history_list; end
  def history_search_pos(string, dir, pos); end
  def history_search_prefix(string, direction); end
  def history_set_pos(pos); end
  def ibuffer_space; end
  def init_line_structures(minsize); end
  def insert_all_matches(matches, point, qc); end
  def insert_match(match, start, mtype, qc); end
  def insert_some_chars(string, count, col); end
  def inv_line(line); end
  def inv_llen(l); end
  def isascii(c); end
  def isprint(c); end
  def m_offset(margin, offset); end
  def make_history_line_current(entry); end
  def make_quoted_replacement(match, mtype, qc); end
  def meta_char(c); end
  def next_history; end
  def no_terminal?; end
  def noninc_dosearch(string, dir); end
  def noninc_search(dir, pchar); end
  def noninc_search_from_pos(string, pos, dir); end
  def parser_else(args); end
  def parser_endif(args); end
  def parser_if(args); end
  def parser_include(args); end
  def path_isdir(filename); end
  def postprocess_matches(matchesp, matching_filenames); end
  def prepare_terminal_settings(meta_flag); end
  def previous_history; end
  def print_filename(to_print, full_pathname); end
  def printable_part(pathname); end
  def prompt_ending_index; end
  def readline(prompt); end
  def readline_default_bindings; end
  def readline_initialize_everything; end
  def readline_internal; end
  def readline_internal_charloop; end
  def readline_internal_setup; end
  def readline_internal_teardown(eof); end
  def redraw_prompt(t); end
  def release_sigint; end
  def remove_duplicate_matches(matches); end
  def remove_history(which); end
  def replace_history_data(which, old, new); end
  def replace_history_entry(which, line, data); end
  def retry_if_interrupted(&block); end
  def rl_abort(count, key); end
  def rl_add_undo(what, start, _end, text); end
  def rl_alphabetic(c); end
  def rl_arrow_keys(count, c); end
  def rl_attempted_completion_function; end
  def rl_attempted_completion_function=(arg0); end
  def rl_attempted_completion_over; end
  def rl_attempted_completion_over=(arg0); end
  def rl_backward(count, key); end
  def rl_backward_byte(count, key); end
  def rl_backward_char(count, key); end
  def rl_backward_char_search(count, key); end
  def rl_backward_kill_line(direction, ignore); end
  def rl_backward_kill_word(count, ignore); end
  def rl_backward_word(count, key); end
  def rl_basic_quote_characters; end
  def rl_basic_quote_characters=(arg0); end
  def rl_basic_word_break_characters; end
  def rl_basic_word_break_characters=(arg0); end
  def rl_beg_of_line(count, key); end
  def rl_begin_undo_group; end
  def rl_beginning_of_history(count, key); end
  def rl_bind_key(key, function); end
  def rl_bind_keyseq_if_unbound(keyseq, default_func); end
  def rl_bind_keyseq_if_unbound_in_map(keyseq, default_func, kmap); end
  def rl_bind_keyseq_in_map(keyseq, function, map); end
  def rl_capitalize_word(count, key); end
  def rl_change_case(count, op); end
  def rl_char_search(count, key); end
  def rl_character_len(c, pos); end
  def rl_cleanup_after_signal; end
  def rl_clear_message; end
  def rl_clear_pending_input; end
  def rl_clear_screen(count, key); end
  def rl_clear_signals; end
  def rl_complete(ignore, invoking_key); end
  def rl_complete_internal(what_to_do); end
  def rl_completer_quote_characters; end
  def rl_completer_quote_characters=(arg0); end
  def rl_completer_word_break_characters; end
  def rl_completer_word_break_characters=(arg0); end
  def rl_completion_append_character; end
  def rl_completion_append_character=(arg0); end
  def rl_completion_matches(text, entry_function); end
  def rl_copy_text(from, to); end
  def rl_crlf; end
  def rl_delete(count, key); end
  def rl_delete_horizontal_space(count, ignore); end
  def rl_delete_or_show_completions(count, key); end
  def rl_delete_text(from, to); end
  def rl_deprep_term_function; end
  def rl_deprep_term_function=(arg0); end
  def rl_deprep_terminal; end
  def rl_digit_argument(ignore, key); end
  def rl_digit_loop; end
  def rl_ding; end
  def rl_display_match_list(matches, len, max); end
  def rl_display_search(search_string, reverse_p, where); end
  def rl_do_lowercase_version(ignore1, ignore2); end
  def rl_do_undo; end
  def rl_downcase_word(count, key); end
  def rl_emacs_editing_mode(count, key); end
  def rl_end_of_history(count, key); end
  def rl_end_of_line(count, key); end
  def rl_end_undo_group; end
  def rl_event_hook; end
  def rl_event_hook=(arg0); end
  def rl_exchange_point_and_mark(count, key); end
  def rl_execute_next(c); end
  def rl_expand_prompt(prompt); end
  def rl_extend_line_buffer(len); end
  def rl_filename_completion_function(text, state); end
  def rl_filename_quote_characters; end
  def rl_filename_quote_characters=(arg0); end
  def rl_forced_update_display; end
  def rl_forward(count, key); end
  def rl_forward_byte(count, key); end
  def rl_forward_char(count, key); end
  def rl_forward_search_history(sign, key); end
  def rl_forward_word(count, key); end
  def rl_free_undo_list; end
  def rl_function_of_keyseq(keyseq, map, type); end
  def rl_gather_tyi; end
  def rl_generic_bind(type, keyseq, data, map); end
  def rl_get_char; end
  def rl_get_keymap_name_from_edit_mode; end
  def rl_get_next_history(count, key); end
  def rl_get_previous_history(count, key); end
  def rl_getc(stream); end
  def rl_initialize; end
  def rl_insert(count, c); end
  def rl_insert_comment(count, key); end
  def rl_insert_completions(ignore, invoking_key); end
  def rl_insert_text(string); end
  def rl_instream; end
  def rl_instream=(arg0); end
  def rl_isstate(x); end
  def rl_kill_full_line(count, ignore); end
  def rl_kill_line(direction, ignore); end
  def rl_kill_text(from, to); end
  def rl_kill_word(count, key); end
  def rl_library_version; end
  def rl_library_version=(arg0); end
  def rl_line_buffer; end
  def rl_maybe_replace_line; end
  def rl_maybe_save_line; end
  def rl_maybe_unsave_line; end
  def rl_message(msg_buf); end
  def rl_modifying(start, _end); end
  def rl_named_function(name); end
  def rl_newline(count, key); end
  def rl_noninc_forward_search(count, key); end
  def rl_noninc_reverse_search(count, key); end
  def rl_on_new_line; end
  def rl_on_new_line_with_prompt; end
  def rl_outstream; end
  def rl_outstream=(arg0); end
  def rl_overwrite_mode(count, key); end
  def rl_parse_and_bind(string); end
  def rl_point; end
  def rl_point=(arg0); end
  def rl_possible_completions(ignore, invoking_key); end
  def rl_prep_terminal(meta_flag); end
  def rl_quoted_insert(count, key); end
  def rl_re_read_init_file(count, ignore); end
  def rl_read_init_file(filename); end
  def rl_read_key; end
  def rl_readline_name; end
  def rl_readline_name=(arg0); end
  def rl_redisplay; end
  def rl_refresh_line(ignore1, ignore2); end
  def rl_replace_from_history(entry, flags); end
  def rl_replace_line(text, clear_undo); end
  def rl_reset_line_state; end
  def rl_resize_terminal; end
  def rl_restart_output(count, key); end
  def rl_restore_prompt; end
  def rl_reverse_search_history(sign, key); end
  def rl_revert_line(count, key); end
  def rl_rubout(count, key); end
  def rl_rubout_or_delete(count, key); end
  def rl_save_prompt; end
  def rl_search_history(direction, invoking_key); end
  def rl_set_keymap_from_edit_mode; end
  def rl_set_mark(count, key); end
  def rl_set_prompt(prompt); end
  def rl_set_signals; end
  def rl_setstate(x); end
  def rl_sigwinch_handler(sig); end
  def rl_stuff_char(key); end
  def rl_tab_insert(count, key); end
  def rl_tilde_expand(ignore, key); end
  def rl_translate_keyseq(seq); end
  def rl_transpose_chars(count, key); end
  def rl_transpose_words(count, key); end
  def rl_tty_set_default_bindings(kmap); end
  def rl_tty_unset_default_bindings(kmap); end
  def rl_undo_command(count, key); end
  def rl_unix_filename_rubout(count, key); end
  def rl_unix_line_discard(count, key); end
  def rl_unix_word_rubout(count, key); end
  def rl_unsetstate(x); end
  def rl_upcase_word(count, key); end
  def rl_username_completion_function(text, state); end
  def rl_variable_bind(name, value); end
  def rl_vi_check; end
  def rl_vi_editing_mode(count, key); end
  def rl_vi_insertion_mode(count, key); end
  def rl_yank(count, ignore); end
  def rl_yank_last_arg(count, key); end
  def rl_yank_nth_arg(count, ignore); end
  def rl_yank_nth_arg_internal(count, ignore, history_skip); end
  def rl_yank_pop(count, key); end
  def save_tty_chars; end
  def self.__rl_fix_point(x); end
  def self._extract_last_quote(string, quote_char); end
  def self._rl_abort_internal; end
  def self._rl_adjust_point(string, point); end
  def self._rl_any_typein; end
  def self._rl_arg_dispatch(cxt, c); end
  def self._rl_arg_getchar; end
  def self._rl_arg_init; end
  def self._rl_arg_overflow; end
  def self._rl_backspace(count); end
  def self._rl_bind_tty_special_chars(kmap); end
  def self._rl_char_search(count, fdir, bdir); end
  def self._rl_char_search_internal(count, dir, smbchar, len); end
  def self._rl_char_value(buf, ind); end
  def self._rl_clean_up_for_exit; end
  def self._rl_clear_screen; end
  def self._rl_clear_to_eol(count); end
  def self._rl_col_width(string, start, _end); end
  def self._rl_compare_chars(buf1, pos1, buf2, pos2); end
  def self._rl_control_keypad(on); end
  def self._rl_copy_to_kill_ring(text, append); end
  def self._rl_current_display_line; end
  def self._rl_dispatch(key, map); end
  def self._rl_dispatch_subseq(key, map, got_subseq); end
  def self._rl_enable_meta_key; end
  def self._rl_erase_at_end_of_line(l); end
  def self._rl_erase_entire_line; end
  def self._rl_find_completion_word; end
  def self._rl_find_next_mbchar(string, seed, count, flags); end
  def self._rl_find_prev_mbchar(string, seed, flags); end
  def self._rl_fix_point(fix_mark_too); end
  def self._rl_get_char_len(src); end
  def self._rl_get_screen_size(tty, ignore_env); end
  def self._rl_history_set_point; end
  def self._rl_init_eightbit; end
  def self._rl_init_line_state; end
  def self._rl_init_terminal_io(terminal_name); end
  def self._rl_input_available; end
  def self._rl_insert_char(count, c); end
  def self._rl_insert_next(count); end
  def self._rl_insert_typein(c); end
  def self._rl_internal_char_cleanup; end
  def self._rl_internal_pager(lines); end
  def self._rl_is_mbchar_matched(string, seed, _end, mbchar, length); end
  def self._rl_isearch_cleanup(cxt, r); end
  def self._rl_isearch_dispatch(cxt, c); end
  def self._rl_isearch_fini(cxt); end
  def self._rl_isearch_init(direction); end
  def self._rl_make_prompt_for_search(pchar); end
  def self._rl_move_cursor_relative(new, data, start = nil); end
  def self._rl_move_vert(to); end
  def self._rl_nsearch_abort(cxt); end
  def self._rl_nsearch_cleanup(cxt, r); end
  def self._rl_nsearch_dispatch(cxt, c); end
  def self._rl_nsearch_dosearch(cxt); end
  def self._rl_nsearch_init(dir, pchar); end
  def self._rl_output_some_chars(string, start, count); end
  def self._rl_overwrite_char(count, c); end
  def self._rl_overwrite_rubout(count, key); end
  def self._rl_read_init_file(filename, include_level); end
  def self._rl_read_mbchar(mbchar, size); end
  def self._rl_read_mbstring(first, mb, mlen); end
  def self._rl_redisplay_after_sigwinch; end
  def self._rl_replace_text(text, start, _end); end
  def self._rl_reset_argument; end
  def self._rl_rubout_char(count, key); end
  def self._rl_scxt_alloc(type, flags); end
  def self._rl_search_getchar(cxt); end
  def self._rl_set_insert_mode(im, force); end
  def self._rl_set_mark_at_pos(position); end
  def self._rl_start_using_history; end
  def self._rl_strip_prompt(pmt); end
  def self._rl_subseq_getchar(key); end
  def self._rl_to_lower(char); end
  def self._rl_unget_char(key); end
  def self._rl_update_final; end
  def self._rl_vi_done_inserting; end
  def self._rl_vi_initialize_line; end
  def self._rl_vi_reset_last; end
  def self._rl_vi_save_insert(up); end
  def self._rl_vi_textmod_command(c); end
  def self._rl_walphabetic(c); end
  def self.add_history(string); end
  def self.alloc_history_entry(string, ts); end
  def self.alloc_undo_entry(what, start, _end, text); end
  def self.append_to_match(text, delimiter, quote_char, nontrivial_match); end
  def self.bind_arrow_keys; end
  def self.bind_arrow_keys_internal(map); end
  def self.bind_termcap_arrow_keys(map); end
  def self.block_sigint; end
  def self.clear_history; end
  def self.compute_lcd_of_matches(match_list, matches, text); end
  def self.cr; end
  def self.cr_faster(new, cur); end
  def self.ctrl_char(c); end
  def self.current_history; end
  def self.delete_chars(count); end
  def self.display_matches(matches); end
  def self.endsrch_char(c); end
  def self.expand_prompt(pmt); end
  def self.fnprint(to_print); end
  def self.fnwidth(string); end
  def self.gen_completion_matches(text, start, _end, our_func, found_quote, quote_char); end
  def self.get_term_capabilities(buffer); end
  def self.get_y_or_n(for_pager); end
  def self.handle_parser_directive(statement); end
  def self.hist_inittime; end
  def self.history_arg_extract(first, last, string); end
  def self.history_base; end
  def self.history_get(offset); end
  def self.history_is_stifled; end
  def self.history_length; end
  def self.history_list; end
  def self.history_search_pos(string, dir, pos); end
  def self.history_search_prefix(string, direction); end
  def self.history_set_pos(pos); end
  def self.ibuffer_space; end
  def self.init_line_structures(minsize); end
  def self.insert_all_matches(matches, point, qc); end
  def self.insert_match(match, start, mtype, qc); end
  def self.insert_some_chars(string, count, col); end
  def self.inv_line(line); end
  def self.inv_llen(l); end
  def self.isascii(c); end
  def self.isprint(c); end
  def self.m_offset(margin, offset); end
  def self.make_history_line_current(entry); end
  def self.make_quoted_replacement(match, mtype, qc); end
  def self.meta_char(c); end
  def self.next_history; end
  def self.no_terminal?; end
  def self.noninc_dosearch(string, dir); end
  def self.noninc_search(dir, pchar); end
  def self.noninc_search_from_pos(string, pos, dir); end
  def self.parser_else(args); end
  def self.parser_endif(args); end
  def self.parser_if(args); end
  def self.parser_include(args); end
  def self.path_isdir(filename); end
  def self.postprocess_matches(matchesp, matching_filenames); end
  def self.prepare_terminal_settings(meta_flag); end
  def self.previous_history; end
  def self.print_filename(to_print, full_pathname); end
  def self.printable_part(pathname); end
  def self.prompt_ending_index; end
  def self.readline(prompt); end
  def self.readline_default_bindings; end
  def self.readline_initialize_everything; end
  def self.readline_internal; end
  def self.readline_internal_charloop; end
  def self.readline_internal_setup; end
  def self.readline_internal_teardown(eof); end
  def self.redraw_prompt(t); end
  def self.release_sigint; end
  def self.remove_duplicate_matches(matches); end
  def self.remove_history(which); end
  def self.replace_history_data(which, old, new); end
  def self.replace_history_entry(which, line, data); end
  def self.retry_if_interrupted(&block); end
  def self.rl_abort(count, key); end
  def self.rl_add_undo(what, start, _end, text); end
  def self.rl_alphabetic(c); end
  def self.rl_arrow_keys(count, c); end
  def self.rl_attempted_completion_function; end
  def self.rl_attempted_completion_function=(arg0); end
  def self.rl_attempted_completion_over; end
  def self.rl_attempted_completion_over=(arg0); end
  def self.rl_backward(count, key); end
  def self.rl_backward_byte(count, key); end
  def self.rl_backward_char(count, key); end
  def self.rl_backward_char_search(count, key); end
  def self.rl_backward_kill_line(direction, ignore); end
  def self.rl_backward_kill_word(count, ignore); end
  def self.rl_backward_word(count, key); end
  def self.rl_basic_quote_characters; end
  def self.rl_basic_quote_characters=(arg0); end
  def self.rl_basic_word_break_characters; end
  def self.rl_basic_word_break_characters=(arg0); end
  def self.rl_beg_of_line(count, key); end
  def self.rl_begin_undo_group; end
  def self.rl_beginning_of_history(count, key); end
  def self.rl_bind_key(key, function); end
  def self.rl_bind_keyseq_if_unbound(keyseq, default_func); end
  def self.rl_bind_keyseq_if_unbound_in_map(keyseq, default_func, kmap); end
  def self.rl_bind_keyseq_in_map(keyseq, function, map); end
  def self.rl_capitalize_word(count, key); end
  def self.rl_change_case(count, op); end
  def self.rl_char_search(count, key); end
  def self.rl_character_len(c, pos); end
  def self.rl_cleanup_after_signal; end
  def self.rl_clear_message; end
  def self.rl_clear_pending_input; end
  def self.rl_clear_screen(count, key); end
  def self.rl_clear_signals; end
  def self.rl_complete(ignore, invoking_key); end
  def self.rl_complete_internal(what_to_do); end
  def self.rl_completer_quote_characters; end
  def self.rl_completer_quote_characters=(arg0); end
  def self.rl_completer_word_break_characters; end
  def self.rl_completer_word_break_characters=(arg0); end
  def self.rl_completion_append_character; end
  def self.rl_completion_append_character=(arg0); end
  def self.rl_completion_matches(text, entry_function); end
  def self.rl_copy_text(from, to); end
  def self.rl_crlf; end
  def self.rl_delete(count, key); end
  def self.rl_delete_horizontal_space(count, ignore); end
  def self.rl_delete_or_show_completions(count, key); end
  def self.rl_delete_text(from, to); end
  def self.rl_deprep_term_function; end
  def self.rl_deprep_term_function=(arg0); end
  def self.rl_deprep_terminal; end
  def self.rl_digit_argument(ignore, key); end
  def self.rl_digit_loop; end
  def self.rl_ding; end
  def self.rl_display_match_list(matches, len, max); end
  def self.rl_display_search(search_string, reverse_p, where); end
  def self.rl_do_lowercase_version(ignore1, ignore2); end
  def self.rl_do_undo; end
  def self.rl_downcase_word(count, key); end
  def self.rl_emacs_editing_mode(count, key); end
  def self.rl_end_of_history(count, key); end
  def self.rl_end_of_line(count, key); end
  def self.rl_end_undo_group; end
  def self.rl_event_hook; end
  def self.rl_event_hook=(arg0); end
  def self.rl_exchange_point_and_mark(count, key); end
  def self.rl_execute_next(c); end
  def self.rl_expand_prompt(prompt); end
  def self.rl_extend_line_buffer(len); end
  def self.rl_filename_completion_function(text, state); end
  def self.rl_filename_quote_characters; end
  def self.rl_filename_quote_characters=(arg0); end
  def self.rl_forced_update_display; end
  def self.rl_forward(count, key); end
  def self.rl_forward_byte(count, key); end
  def self.rl_forward_char(count, key); end
  def self.rl_forward_search_history(sign, key); end
  def self.rl_forward_word(count, key); end
  def self.rl_free_undo_list; end
  def self.rl_function_of_keyseq(keyseq, map, type); end
  def self.rl_gather_tyi; end
  def self.rl_generic_bind(type, keyseq, data, map); end
  def self.rl_get_char; end
  def self.rl_get_keymap_name_from_edit_mode; end
  def self.rl_get_next_history(count, key); end
  def self.rl_get_previous_history(count, key); end
  def self.rl_getc(stream); end
  def self.rl_initialize; end
  def self.rl_insert(count, c); end
  def self.rl_insert_comment(count, key); end
  def self.rl_insert_completions(ignore, invoking_key); end
  def self.rl_insert_text(string); end
  def self.rl_instream; end
  def self.rl_instream=(arg0); end
  def self.rl_isstate(x); end
  def self.rl_kill_full_line(count, ignore); end
  def self.rl_kill_line(direction, ignore); end
  def self.rl_kill_text(from, to); end
  def self.rl_kill_word(count, key); end
  def self.rl_library_version; end
  def self.rl_library_version=(arg0); end
  def self.rl_line_buffer; end
  def self.rl_maybe_replace_line; end
  def self.rl_maybe_save_line; end
  def self.rl_maybe_unsave_line; end
  def self.rl_message(msg_buf); end
  def self.rl_modifying(start, _end); end
  def self.rl_named_function(name); end
  def self.rl_newline(count, key); end
  def self.rl_noninc_forward_search(count, key); end
  def self.rl_noninc_reverse_search(count, key); end
  def self.rl_on_new_line; end
  def self.rl_on_new_line_with_prompt; end
  def self.rl_outstream; end
  def self.rl_outstream=(arg0); end
  def self.rl_overwrite_mode(count, key); end
  def self.rl_parse_and_bind(string); end
  def self.rl_point; end
  def self.rl_possible_completions(ignore, invoking_key); end
  def self.rl_prep_terminal(meta_flag); end
  def self.rl_quoted_insert(count, key); end
  def self.rl_re_read_init_file(count, ignore); end
  def self.rl_read_init_file(filename); end
  def self.rl_read_key; end
  def self.rl_readline_name; end
  def self.rl_readline_name=(arg0); end
  def self.rl_redisplay; end
  def self.rl_refresh_line(ignore1, ignore2); end
  def self.rl_replace_from_history(entry, flags); end
  def self.rl_replace_line(text, clear_undo); end
  def self.rl_reset_line_state; end
  def self.rl_resize_terminal; end
  def self.rl_restart_output(count, key); end
  def self.rl_restore_prompt; end
  def self.rl_reverse_search_history(sign, key); end
  def self.rl_revert_line(count, key); end
  def self.rl_rubout(count, key); end
  def self.rl_rubout_or_delete(count, key); end
  def self.rl_save_prompt; end
  def self.rl_search_history(direction, invoking_key); end
  def self.rl_set_keymap_from_edit_mode; end
  def self.rl_set_mark(count, key); end
  def self.rl_set_prompt(prompt); end
  def self.rl_set_signals; end
  def self.rl_setstate(x); end
  def self.rl_sigwinch_handler(sig); end
  def self.rl_stuff_char(key); end
  def self.rl_tab_insert(count, key); end
  def self.rl_tilde_expand(ignore, key); end
  def self.rl_translate_keyseq(seq); end
  def self.rl_transpose_chars(count, key); end
  def self.rl_transpose_words(count, key); end
  def self.rl_tty_set_default_bindings(kmap); end
  def self.rl_tty_unset_default_bindings(kmap); end
  def self.rl_undo_command(count, key); end
  def self.rl_unix_filename_rubout(count, key); end
  def self.rl_unix_line_discard(count, key); end
  def self.rl_unix_word_rubout(count, key); end
  def self.rl_unsetstate(x); end
  def self.rl_upcase_word(count, key); end
  def self.rl_username_completion_function(text, state); end
  def self.rl_variable_bind(name, value); end
  def self.rl_vi_check; end
  def self.rl_vi_editing_mode(count, key); end
  def self.rl_vi_insertion_mode(count, key); end
  def self.rl_yank(count, ignore); end
  def self.rl_yank_last_arg(count, key); end
  def self.rl_yank_nth_arg(count, ignore); end
  def self.rl_yank_nth_arg_internal(count, ignore, history_skip); end
  def self.rl_yank_pop(count, key); end
  def self.save_tty_chars; end
  def self.set_completion_defaults(what_to_do); end
  def self.sh_set_lines_and_columns(lines, cols); end
  def self.space_to_eol(count); end
  def self.stat_char(filename); end
  def self.stifle_history(max); end
  def self.tgetflag(name); end
  def self.trans(i); end
  def self.unstifle_history; end
  def self.update_line(old, ostart, new, current_line, omax, nmax, inv_botlin); end
  def self.using_history; end
  def self.vis_chars(line); end
  def self.vis_line(line); end
  def self.vis_llen(l); end
  def self.vis_pos(line); end
  def self.w_offset(line, offset); end
  def self.where_history; end
  def self.whitespace(c); end
  def set_completion_defaults(what_to_do); end
  def sh_set_lines_and_columns(lines, cols); end
  def space_to_eol(count); end
  def stat_char(filename); end
  def stifle_history(max); end
  def tgetflag(name); end
  def trans(i); end
  def unstifle_history; end
  def update_line(old, ostart, new, current_line, omax, nmax, inv_botlin); end
  def using_history; end
  def vis_chars(line); end
  def vis_line(line); end
  def vis_llen(l); end
  def vis_pos(line); end
  def w_offset(line, offset); end
  def where_history; end
  def whitespace(c); end
end
class Integer < Numeric
end
module Readline
  def readline(prompt = nil, add_history = nil); end
  def self.basic_quote_characters; end
  def self.basic_quote_characters=(str); end
  def self.basic_word_break_characters; end
  def self.basic_word_break_characters=(str); end
  def self.completer_quote_characters; end
  def self.completer_quote_characters=(str); end
  def self.completer_word_break_characters; end
  def self.completer_word_break_characters=(str); end
  def self.completion_append_character; end
  def self.completion_append_character=(char); end
  def self.completion_case_fold; end
  def self.completion_case_fold=(bool); end
  def self.completion_proc; end
  def self.completion_proc=(proc); end
  def self.emacs_editing_mode; end
  def self.filename_quote_characters; end
  def self.filename_quote_characters=(str); end
  def self.input=(input); end
  def self.line_buffer; end
  def self.output=(output); end
  def self.point; end
  def self.readline(prompt = nil, add_history = nil); end
  def self.readline_attempted_completion_function(text, start, _end); end
  def self.silence_warnings(&block); end
  def self.vi_editing_mode; end
  include RbReadline
end
class Readline::History
  def self.<<(str); end
  def self.[](index); end
  def self.[]=(index, str); end
  def self.delete_at(index); end
  def self.each; end
  def self.empty?; end
  def self.length; end
  def self.pop; end
  def self.push(*args); end
  def self.rb_remove_history(index); end
  def self.shift; end
  def self.size; end
  def self.to_s; end
  extend Enumerable
end
class Readline::Fcomp
  def self.call(str); end
end
class Readline::Ucomp
  def self.call(str); end
end
