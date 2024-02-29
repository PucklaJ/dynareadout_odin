package dynareadout

when ODIN_OS == .Windows {
    foreign import "system:dynareadout.lib"
} else {
    foreign import "system:dynareadout"
}

import _c "core:c"
import "core:math/bits"

EXTRA_STRING_BUFFER_SIZE :: 80 + 2

d3_word :: u64
d3plot_thick_shell_con :: d3plot_solid_con
key_file_callback :: #type proc "c" (
    info: key_parse_info_t,
    keyword_name: cstring,
    card: ^card_t,
    card_index: _c.size_t,
    user_data: rawptr,
)

card_parse_type :: enum i32 {
    INT,
    FLOAT,
    STRING,
}

binout_type :: enum u8 {
    INT8    = 1,
    INT16   = 2,
    INT32   = 3,
    INT64   = 4,
    UINT8   = 5,
    UINT16  = 6,
    UINT32  = 7,
    UINT64  = 8,
    FLOAT32 = 9,
    FLOAT64 = 10,
    INVALID = bits.U8_MAX,
}

d3plot_solid_con :: struct {
    node_indices:   [8]d3_word,
    material_index: d3_word,
}

d3plot_beam_con :: struct {
    node_indices:           [2]d3_word,
    orientation_node_index: d3_word,
    null:                   [2]d3_word,
    material_index:         d3_word,
}

d3plot_shell_con :: struct {
    node_indices:   [4]d3_word,
    material_index: d3_word,
}

d3plot_part :: struct {
    solid_ids:           [^]d3_word,
    thick_shell_ids:     [^]d3_word,
    beam_ids:            [^]d3_word,
    shell_ids:           [^]d3_word,
    solid_indices:       [^]_c.size_t,
    thick_shell_indices: [^]_c.size_t,
    beam_indices:        [^]_c.size_t,
    shell_indices:       [^]_c.size_t,
    num_solids:          _c.size_t,
    num_thick_shells:    _c.size_t,
    num_beams:           _c.size_t,
    num_shells:          _c.size_t,
}

d3plot_tensor :: struct {
    x:  _c.double,
    y:  _c.double,
    z:  _c.double,
    xy: _c.double,
    yz: _c.double,
    zx: _c.double,
}

d3plot_x_y :: struct {
    x: _c.double,
    y: _c.double,
}

d3plot_x_y_xy :: struct {
    x:  _c.double,
    y:  _c.double,
    xy: _c.double,
}

d3plot_solid :: struct {
    stress:                   d3plot_tensor,
    effective_plastic_strain: _c.double,
    strain:                   d3plot_tensor,
}

d3plot_surface :: struct {
    stress:                   d3plot_tensor,
    effective_plastic_strain: _c.double,
    history_variables:        [^]_c.double,
}

d3plot_thick_shell :: struct {
    mid:                               d3plot_surface,
    inner:                             d3plot_surface,
    outer:                             d3plot_surface,
    add_ips:                           [^]d3plot_surface,
    inner_strain:                      d3plot_tensor,
    outer_strain:                      d3plot_tensor,
    num_history_variables:             _c.size_t,
    num_additional_integration_points: _c.size_t,
}

d3plot_beam :: struct {
    axial_force:         _c.double,
    s_shear_resultant:   _c.double,
    t_shear_resultant:   _c.double,
    s_bending_moment:    _c.double,
    t_bending_moment:    _c.double,
    torsional_resultant: _c.double,
}

d3plot_shell :: struct {
    mid:                               d3plot_surface,
    inner:                             d3plot_surface,
    outer:                             d3plot_surface,
    add_ips:                           [^]d3plot_surface,
    inner_strain:                      d3plot_tensor,
    outer_strain:                      d3plot_tensor,
    bending_moment:                    d3plot_x_y_xy,
    shear_resultant:                   d3plot_x_y,
    normal_resultant:                  d3plot_x_y_xy,
    thickness:                         _c.double,
    element_dependent_variables:       [2]_c.double,
    internal_energy:                   _c.double,
    num_history_variables:             _c.size_t,
    num_additional_integration_points: _c.size_t,
}

card_t :: struct {
    string:        cstring,
    current_index: u8,
    value_width:   u8,
}

keyword_t :: struct {
    name:      cstring,
    cards:     [^]card_t,
    num_cards: _c.size_t,
}

key_parse_config_t :: struct {
    parse_includes:            _c.int,
    ignore_not_found_includes: _c.int,
    extra_include_paths:       [^]cstring,
    num_extra_include_paths:   _c.size_t,
}

key_parse_info_t :: struct {
    file_name:         cstring,
    line_number:       _c.size_t,
    include_paths:     [^]cstring,
    num_include_paths: _c.size_t,
    root_folder:       cstring,
}

@(private)
binout_directory_t :: struct {
    children:     rawptr,
    num_children: _c.size_t,
}

binout_file :: struct {
    directory:       binout_directory_t,
    files:           rawptr,
    num_files:       _c.size_t,
    file_errors:     [^]cstring,
    num_file_errors: _c.size_t,
    error_string:    cstring,
}

@(private)
d3_buffer :: struct {
    root_file_name:        cstring,
    root_file_name_length: _c.size_t,
    files:                 rawptr,
    num_files:             _c.size_t,
    first_open_file:       _c.size_t,
    last_open_file:        _c.size_t,
    word_size:             u8,
    error_string:          cstring,
}

@(private)
d3_control_data :: struct {
    ndim:                        d3_word,
    numnp:                       d3_word,
    nglbv:                       d3_word,
    it:                          d3_word,
    iu:                          d3_word,
    iv:                          d3_word,
    ia:                          d3_word,
    nummat8:                     d3_word,
    numds:                       d3_word,
    numst:                       d3_word,
    nv3d:                        d3_word,
    nel2:                        d3_word,
    nummat2:                     d3_word,
    nv1d:                        d3_word,
    nel4:                        d3_word,
    nummat4:                     d3_word,
    nv2d:                        d3_word,
    neiph:                       d3_word,
    neips:                       d3_word,
    nmsph:                       d3_word,
    narbs:                       d3_word,
    nelt:                        d3_word,
    nummatt:                     d3_word,
    nv3dt:                       d3_word,
    ioshl:                       [4]d3_word,
    ialemat:                     d3_word,
    ncfdv1:                      d3_word,
    nadapt:                      d3_word,
    nmmat:                       d3_word,
    nel48:                       d3_word,
    nel20:                       d3_word,
    nt3d:                        d3_word,
    nel27:                       d3_word,
    neipb:                       d3_word,
    nel21p:                      d3_word,
    nel15t:                      d3_word,
    soleng:                      d3_word,
    nel20t:                      d3_word,
    nel40p:                      d3_word,
    nel64:                       d3_word,
    quadr:                       d3_word,
    cubic:                       d3_word,
    tsheng:                      d3_word,
    nbranch:                     d3_word,
    penout:                      d3_word,
    engout:                      d3_word,
    bemeng:                      d3_word,
    kineng:                      d3_word,
    npart:                       d3_word,
    numrbs:                      d3_word,
    beamip:                      d3_word,
    nel8:                        i64,
    maxint:                      i64,
    mdlopt:                      b8,
    istrn:                       b8,
    iosol:                       [2]b8,
    element_connectivity_packed: b8,
}

d3plot_file :: struct {
    control_data:  d3_control_data,
    data_pointers: [^]_c.size_t,
    num_states:    _c.size_t,
    buffer:        d3_buffer,
    error_string:  cstring,
}

include_transform_t :: struct {
    file_name: cstring,
    idnoff:    i64,
    ideoff:    i64,
    idpoff:    i64,
    idmoff:    i64,
    idsoff:    i64,
    idfoff:    i64,
    iddoff:    i64,
    idroff:    i64,
    prefix:    cstring,
    suffix:    cstring,
    fctmas:    _c.double,
    fcttim:    _c.double,
    fctlen:    _c.double,
    fcttem:    cstring,
    incout1:   i64,
    tranid:    i64,
}

transformation_option_t :: struct {
    name:       cstring,
    parameters: [7]_c.double,
}

define_transformation_t :: struct {
    tranid:      i64,
    title:       cstring,
    options:     [^]transformation_option_t,
    num_options: _c.size_t,
}

@(default_calling_convention = "c")
foreign dynareadout {
    @(link_name = "key_default_parse_config")
    key_default_parse_config :: proc() -> key_parse_config_t ---

    @(link_name = "key_file_parse")
    key_file_parse :: proc(file_name: cstring, num_keywords: ^_c.size_t, parse_config: ^key_parse_config_t, error_string: ^cstring, warning_string: ^cstring) -> [^]keyword_t ---

    @(link_name = "key_file_parse_with_callback")
    key_file_parse_with_callback :: proc(file_name: cstring, callback: key_file_callback, parse_config: ^key_parse_config_t = nil, error_string: ^cstring = nil, warning_string: ^cstring = nil, user_data: rawptr = nil, rec: rawptr = nil) ---

    @(link_name = "key_file_free")
    key_file_free :: proc(keywords: [^]keyword_t, num_keywords: _c.size_t) ---

    @(link_name = "key_file_get")
    key_file_get :: proc(keywords: [^]keyword_t, num_keywords: _c.size_t, name: cstring, index: _c.size_t) -> ^keyword_t ---

    @(link_name = "key_file_get_slice")
    key_file_get_slice :: proc(keywords: [^]keyword_t, num_keywords: _c.size_t, name: cstring, slice_size: ^_c.size_t) -> [^]keyword_t ---

    @(link_name = "card_parse_begin")
    card_parse_begin :: proc(card: ^card_t, value_width: u8) ---

    @(link_name = "card_parse_next")
    card_parse_next :: proc(card: ^card_t) ---

    @(link_name = "card_parse_next_width")
    card_parse_next_width :: proc(card: ^card_t, value_width: u8) ---

    @(link_name = "card_parse_done")
    card_parse_done :: proc(card: ^card_t) -> b32 ---

    @(link_name = "card_parse_int")
    card_parse_int :: proc(card: ^card_t) -> i64 ---

    @(link_name = "card_parse_int_width")
    card_parse_int_width :: proc(card: ^card_t, value_width: u8) -> i64 ---

    @(link_name = "card_parse_float32")
    card_parse_float32 :: proc(card: ^card_t) -> _c.float ---

    @(link_name = "card_parse_float32_width")
    card_parse_float32_width :: proc(card: ^card_t, value_width: u8) -> _c.float ---

    @(link_name = "card_parse_float64")
    card_parse_float64 :: proc(card: ^card_t) -> _c.double ---

    @(link_name = "card_parse_float64_width")
    card_parse_float64_width :: proc(card: ^card_t, value_width: u8) -> _c.double ---

    @(link_name = "card_parse_string")
    card_parse_string :: proc(card: ^card_t) -> cstring ---

    @(link_name = "card_parse_string_no_trim")
    card_parse_string_no_trim :: proc(card: ^card_t) -> cstring ---

    @(link_name = "card_parse_string_width")
    card_parse_string_width :: proc(card: ^card_t, value_width: u8) -> cstring ---

    @(link_name = "card_parse_string_width_no_trim")
    card_parse_string_width_no_trim :: proc(card: ^card_t, value_width: u8) -> cstring ---

    @(link_name = "card_parse_whole")
    card_parse_whole :: proc(card: ^card_t) -> cstring ---

    @(link_name = "card_parse_whole_no_trim")
    card_parse_whole_no_trim :: proc(card: ^card_t) -> cstring ---

    @(link_name = "card_parse_get_type")
    card_parse_get_type :: proc(card: ^card_t) -> card_parse_type ---

    @(link_name = "card_parse_get_type_width")
    card_parse_get_type_width :: proc(card: ^card_t, value_width: u8) -> card_parse_type ---

    @(link_name = "binout_read_i8")
    binout_read_i8 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]i8 ---

    @(link_name = "binout_read_i16")
    binout_read_i16 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]i16 ---

    @(link_name = "binout_read_i32")
    binout_read_i32 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]i32 ---

    @(link_name = "binout_read_i64")
    binout_read_i64 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]i64 ---

    @(link_name = "binout_read_u8")
    binout_read_u8 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]u8 ---

    @(link_name = "binout_read_u16")
    binout_read_u16 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]u16 ---

    @(link_name = "binout_read_u32")
    binout_read_u32 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]u32 ---

    @(link_name = "binout_read_u64")
    binout_read_u64 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]u64 ---

    @(link_name = "binout_read_f32")
    binout_read_f32 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "binout_read_f64")
    binout_read_f64 :: proc(bin_file: ^binout_file, path_to_variable: cstring, data_size: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "binout_read_timed_i8")
    binout_read_timed_i8 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]i8 ---

    @(link_name = "binout_read_timed_i16")
    binout_read_timed_i16 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]i16 ---

    @(link_name = "binout_read_timed_i32")
    binout_read_timed_i32 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]i32 ---

    @(link_name = "binout_read_timed_i64")
    binout_read_timed_i64 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]i64 ---

    @(link_name = "binout_read_timed_u8")
    binout_read_timed_u8 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]u8 ---

    @(link_name = "binout_read_timed_u16")
    binout_read_timed_u16 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]u16 ---

    @(link_name = "binout_read_timed_u32")
    binout_read_timed_u32 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]u32 ---

    @(link_name = "binout_read_timed_u64")
    binout_read_timed_u64 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]u64 ---

    @(link_name = "binout_read_timed_f32")
    binout_read_timed_f32 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "binout_read_timed_f64")
    binout_read_timed_f64 :: proc(bin_file: ^binout_file, variable: cstring, num_values: ^_c.size_t, num_timesteps: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "binout_open")
    binout_open :: proc(file_name: cstring) -> binout_file ---

    @(link_name = "binout_close")
    binout_close :: proc(bin_file: ^binout_file) ---

    @(link_name = "binout_get_type_id")
    binout_get_type_id :: proc(bin_file: ^binout_file, path_to_variable: cstring) -> binout_type ---

    @(link_name = "binout_variable_exists")
    binout_variable_exists :: proc(bin_file: ^binout_file, path_to_variable: cstring) -> b32 ---

    @(link_name = "binout_get_children")
    binout_get_children :: proc(bin_file: ^binout_file, path: cstring, num_children: ^_c.size_t) -> [^]cstring ---

    @(link_name = "binout_free_children")
    binout_free_children :: proc(children: [^]cstring) ---

    @(link_name = "binout_open_error")
    binout_open_error :: proc(bin_file: ^binout_file) -> cstring ---

    @(link_name = "binout_get_num_timesteps")
    binout_get_num_timesteps :: proc(bin_file: ^binout_file, path: cstring) -> _c.size_t ---

    @(link_name = "binout_simple_path_to_real")
    binout_simple_path_to_real :: proc(bin_file: ^binout_file, simple: cstring, type_id: ^binout_type, timed: ^b32) -> cstring ---

    @(link_name = "d3plot_open")
    d3plot_open :: proc(root_file_name: cstring) -> d3plot_file ---

    @(link_name = "d3plot_close")
    d3plot_close :: proc(plot_file: ^d3plot_file) ---

    @(link_name = "d3plot_read_node_ids")
    d3plot_read_node_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_read_solid_element_ids")
    d3plot_read_solid_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_read_beam_element_ids")
    d3plot_read_beam_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_read_shell_element_ids")
    d3plot_read_shell_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_read_thick_shell_element_ids")
    d3plot_read_thick_shell_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_read_part_ids")
    d3plot_read_part_ids :: proc(plot_file: ^d3plot_file, num_parts: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_read_part_titles")
    d3plot_read_part_titles :: proc(plot_file: ^d3plot_file, num_parts: ^_c.size_t) -> [^]cstring ---

    @(link_name = "d3plot_read_node_coordinates")
    d3plot_read_node_coordinates :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_nodes: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_all_node_coordinates")
    d3plot_read_all_node_coordinates :: proc(plot_file: ^d3plot_file, num_nodes: ^_c.size_t, num_time_steps: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_node_velocity")
    d3plot_read_node_velocity :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_nodes: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_all_node_velocity")
    d3plot_read_all_node_velocity :: proc(plot_file: ^d3plot_file, num_nodes: ^_c.size_t, num_time_steps: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_node_acceleration")
    d3plot_read_node_acceleration :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_nodes: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_all_node_acceleration")
    d3plot_read_all_node_acceleration :: proc(plot_file: ^d3plot_file, num_nodes: ^_c.size_t, num_time_steps: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_node_coordinates_32")
    d3plot_read_node_coordinates_32 :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_nodes: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_all_node_coordinates_32")
    d3plot_read_all_node_coordinates_32 :: proc(plot_file: ^d3plot_file, num_nodes: ^_c.size_t, num_time_steps: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_node_velocity_32")
    d3plot_read_node_velocity_32 :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_nodes: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_all_node_velocity_32")
    d3plot_read_all_node_velocity_32 :: proc(plot_file: ^d3plot_file, num_nodes: ^_c.size_t, num_time_steps: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_node_acceleration_32")
    d3plot_read_node_acceleration_32 :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_nodes: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_all_node_acceleration_32")
    d3plot_read_all_node_acceleration_32 :: proc(plot_file: ^d3plot_file, num_nodes: ^_c.size_t, num_time_steps: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_time")
    d3plot_read_time :: proc(plot_file: ^d3plot_file, state: _c.size_t) -> _c.double ---

    @(link_name = "d3plot_read_all_time")
    d3plot_read_all_time :: proc(plot_file: ^d3plot_file, num_states: ^_c.size_t) -> [^]_c.double ---

    @(link_name = "d3plot_read_time_32")
    d3plot_read_time_32 :: proc(plot_file: ^d3plot_file, state: _c.size_t) -> _c.float ---

    @(link_name = "d3plot_read_all_time_32")
    d3plot_read_all_time_32 :: proc(plot_file: ^d3plot_file, num_states: ^_c.size_t) -> [^]_c.float ---

    @(link_name = "d3plot_read_solids_state")
    d3plot_read_solids_state :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_solids: ^_c.size_t) -> [^]d3plot_solid ---

    @(link_name = "d3plot_read_thick_shells_state")
    d3plot_read_thick_shells_state :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_thick_shells: ^_c.size_t, num_history_variables: ^_c.size_t) -> [^]d3plot_thick_shell ---

    @(link_name = "d3plot_read_beams_state")
    d3plot_read_beams_state :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_beams: ^_c.size_t) -> [^]d3plot_beam ---

    @(link_name = "d3plot_read_shells_state")
    d3plot_read_shells_state :: proc(plot_file: ^d3plot_file, state: _c.size_t, num_shells: ^_c.size_t, num_history_variables: ^_c.size_t) -> [^]d3plot_shell ---

    @(link_name = "d3plot_read_solid_elements")
    d3plot_read_solid_elements :: proc(plot_file: ^d3plot_file, num_solids: ^_c.size_t) -> [^]d3plot_solid_con ---

    @(link_name = "d3plot_read_thick_shell_elements")
    d3plot_read_thick_shell_elements :: proc(plot_file: ^d3plot_file, num_thick_shells: ^_c.size_t) -> [^]d3plot_thick_shell_con ---

    @(link_name = "d3plot_read_beam_elements")
    d3plot_read_beam_elements :: proc(plot_file: ^d3plot_file, num_beams: ^_c.size_t) -> [^]d3plot_beam_con ---

    @(link_name = "d3plot_read_shell_elements")
    d3plot_read_shell_elements :: proc(plot_file: ^d3plot_file, num_shells: ^_c.size_t) -> [^]d3plot_shell_con ---

    @(link_name = "d3plot_read_title")
    d3plot_read_title :: proc(plot_file: ^d3plot_file) -> cstring ---

    @(link_name = "d3plot_read_run_time")
    d3plot_read_run_time :: proc(plot_file: ^d3plot_file) -> rawptr ---

    @(link_name = "d3plot_read_part")
    d3plot_read_part :: proc(plot_file: ^d3plot_file, part_index: _c.size_t) -> d3plot_part ---

    @(link_name = "d3plot_read_part_by_id")
    d3plot_read_part_by_id :: proc(plot_file: ^d3plot_file, part_id: d3_word, part_ids: [^]d3_word = nil, num_parts: _c.size_t = 0) -> d3plot_part ---

    @(link_name = "d3plot_get_shell_mean")
    d3plot_get_shell_mean :: proc(shell: ^d3plot_shell) -> d3plot_surface ---

    @(link_name = "d3plot_get_thick_shell_mean")
    d3plot_get_thick_shell_mean :: proc(thick_shell: ^d3plot_thick_shell) -> d3plot_surface ---

    @(link_name = "d3plot_free_surface")
    d3plot_free_surface :: proc(ip: d3plot_surface) ---

    @(link_name = "d3plot_free_part")
    d3plot_free_part :: proc(part: ^d3plot_part) ---

    @(link_name = "d3plot_free_shells_state")
    d3plot_free_shells_state :: proc(shells: ^d3plot_shell) ---

    @(link_name = "d3plot_free_thick_shells_state")
    d3plot_free_thick_shells_state :: proc(thick_shells: ^d3plot_thick_shell) ---

    @(link_name = "d3plot_read_all_element_ids")
    d3plot_read_all_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "d3plot_index_for_id")
    d3plot_index_for_id :: proc(id: d3_word, ids: [^]d3_word, num_ids: _c.size_t) -> _c.size_t ---

    @(link_name = "d3plot_part_get_node_ids2")
    d3plot_part_get_node_ids2 :: proc(plot_file: ^d3plot_file, part: ^d3plot_part, num_part_node_ids: ^_c.size_t, node_ids: [^]d3_word = nil, num_nodes: _c.size_t = 0, solid_ids: [^]d3_word = nil, num_solids: _c.size_t = 0, beam_ids: [^]d3_word = nil, num_beams: _c.size_t = 0, shell_ids: [^]d3_word = nil, num_shells: _c.size_t = 0, thick_shell_ids: [^]d3_word = nil, num_thick_shells: _c.size_t = 0, solid_cons: [^]d3plot_solid_con = nil, beam_cons: [^]d3plot_beam_con = nil, shell_cons: [^]d3plot_shell_con = nil, thick_shell_cons: [^]d3plot_thick_shell_con = nil) -> [^]d3_word ---

    @(link_name = "d3plot_part_get_node_indices2")
    d3plot_part_get_node_indices2 :: proc(plot_file: ^d3plot_file, part: ^d3plot_part, num_part_node_indices: ^_c.size_t, solid_ids: [^]d3_word = nil, num_solids: _c.size_t = 0, beam_ids: [^]d3_word = nil, num_beams: _c.size_t = 0, shell_ids: [^]d3_word = nil, num_shells: _c.size_t = 0, thick_shell_ids: [^]d3_word = nil, num_thick_shells: _c.size_t = 0, solid_cons: [^]d3plot_solid_con = nil, beam_cons: [^]d3plot_beam_con = nil, shell_cons: [^]d3plot_shell_con = nil, thick_shell_cons: [^]d3plot_thick_shell_con = nil) -> [^]d3_word ---

    @(link_name = "d3plot_part_get_num_nodes2")
    d3plot_part_get_num_nodes2 :: proc(plot_file: ^d3plot_file, part: ^d3plot_part, solid_ids: [^]d3_word = nil, num_solids: _c.size_t = 0, beam_ids: [^]d3_word = nil, num_beams: _c.size_t = 0, shell_ids: [^]d3_word = nil, num_shells: _c.size_t = 0, thick_shell_ids: [^]d3_word = nil, num_thick_shells: _c.size_t = 0, solid_cons: [^]d3plot_solid_con = nil, beam_cons: [^]d3plot_beam_con = nil, shell_cons: [^]d3plot_shell_con = nil, thick_shell_cons: [^]d3plot_thick_shell_con = nil) -> _c.size_t ---

    @(link_name = "d3plot_part_get_num_elements")
    d3plot_part_get_num_elements :: proc(part: ^d3plot_part) -> _c.size_t ---

    @(link_name = "d3plot_part_get_all_element_ids")
    d3plot_part_get_all_element_ids :: proc(part: ^d3plot_part, num_ids: ^_c.size_t) -> [^]d3_word ---

    @(link_name = "key_parse_include_transform")
    key_parse_include_transform :: proc(keyword: ^keyword_t) -> include_transform_t ---

    @(link_name = "key_parse_include_transform_card")
    key_parse_include_transform_card :: proc(it: ^include_transform_t, card: ^card_t, card_index: _c.size_t) ---

    @(link_name = "key_parse_define_transformation")
    key_parse_define_transformation :: proc(keyword: ^keyword_t, is_title: b32) -> define_transformation_t ---

    @(link_name = "key_parse_define_transformation_card")
    key_parse_define_transformation_card :: proc(dt: ^define_transformation_t, card: ^card_t, card_index: _c.size_t, is_title: b32) ---

    @(link_name = "key_free_include_transform")
    key_free_include_transform :: proc(it: ^include_transform_t) ---

    @(link_name = "key_free_define_transformation")
    key_free_define_transformation :: proc(dt: ^define_transformation_t) ---
}

