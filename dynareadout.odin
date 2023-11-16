package dynareadout

when ODIN_OS == .Windows {
    foreign import "system:dynareadout.lib"
} else {
    foreign import "system:dynareadout"
}

import _c "core:c"


d3_word :: u64
d3plot_thick_shell_con :: d3plot_solid_con
key_file_callback :: #type proc "c" (
    info: key_parse_info_t,
    keyword_name: cstring,
    card: ^card_t,
    card_index: _c.size_t,
    user_data: rawptr,
)

AnonymousEnum0 :: enum i32 {
    BINOUT_FILE,
    BINOUT_FOLDER,
}

card_parse_type :: enum i32 {
    CARD_PARSE_INT,
    CARD_PARSE_FLOAT,
    CARD_PARSE_STRING,
}

AnonymousEnum2 :: enum i32 {
    BINOUT_FILE,
    BINOUT_FOLDER,
}

AnonymousEnum3 :: enum i32 {
    BINOUT_FILE,
    BINOUT_FOLDER,
}

AnonymousEnum6 :: enum i32 {
    BINOUT_FILE,
    BINOUT_FOLDER,
}

path_view_t :: struct {
    string: cstring,
    start:  _c.int,
    end:    _c.int,
}

binout_folder_or_file_t :: struct {
    type: u8,
}

binout_file_t :: struct {
    type:       u8,
    name:       cstring,
    var_type:   u8,
    size:       _c.size_t,
    file_index: u8,
    file_pos:   _c.long,
}

binout_folder_t :: struct {
    type:         u8,
    name:         cstring,
    children:     rawptr,
    num_children: _c.size_t,
}

binout_directory_t :: struct {
    children:     ^binout_folder_t,
    num_children: _c.size_t,
}

d3plot_solid_con :: struct {
    node_indices:   [8]u64,
    material_index: u64,
}

d3plot_beam_con :: struct {
    node_indices:           [2]u64,
    orientation_node_index: u64,
    null:                   [2]u64,
    material_index:         u64,
}

d3plot_shell_con :: struct {
    node_indices:   [4]u64,
    material_index: u64,
}

d3plot_part :: struct {
    solid_ids:           ^u64,
    thick_shell_ids:     ^u64,
    beam_ids:            ^u64,
    shell_ids:           ^u64,
    solid_indices:       ^_c.size_t,
    thick_shell_indices: ^_c.size_t,
    beam_indices:        ^_c.size_t,
    shell_indices:       ^_c.size_t,
    num_solids:          _c.size_t,
    num_thick_shells:    _c.size_t,
    num_beams:           _c.size_t,
    num_shells:          _c.size_t,
}

d3plot_tensor :: struct {
    x:       _c.double,
    y:       _c.double,
    z:       _c.double,
    unamed0: AnonymousUnion84,
    unamed1: AnonymousUnion85,
    unamed2: AnonymousUnion86,
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
    unamed0: AnonymousUnion87,
    unamed1: AnonymousUnion88,
    unamed2: AnonymousUnion89,
}

d3plot_surface :: struct {
    unamed0:           AnonymousUnion90,
    unamed1:           AnonymousUnion91,
    history_variables: ^_c.double,
}

d3plot_thick_shell :: struct {
    mid:     d3plot_surface,
    inner:   d3plot_surface,
    outer:   d3plot_surface,
    unamed0: AnonymousUnion92,
    unamed1: AnonymousUnion93,
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
    mid:                         d3plot_surface,
    inner:                       d3plot_surface,
    outer:                       d3plot_surface,
    unamed0:                     AnonymousUnion94,
    unamed1:                     AnonymousUnion95,
    bending_moment:              d3plot_x_y_xy,
    shear_resultant:             d3plot_x_y,
    normal_resultant:            d3plot_x_y_xy,
    thickness:                   _c.double,
    element_dependent_variables: [2]_c.double,
    internal_energy:             _c.double,
}

extra_string :: struct {
    buffer: [82]_c.char,
    extra:  cstring,
}

string_builder_t :: struct {
    buffer: cstring,
    ptr:    _c.size_t,
    cap:    _c.size_t,
}

card_t :: struct {
    string:        cstring,
    current_index: u8,
    value_width:   u8,
}

keyword_t :: struct {
    name:      cstring,
    cards:     ^card_t,
    num_cards: _c.size_t,
}

key_parse_config_t :: struct {
    parse_includes:            _c.int,
    ignore_not_found_includes: _c.int,
    extra_include_paths:       ^cstring,
    num_extra_include_paths:   _c.size_t,
}

key_parse_recursion_t :: struct {
    include_paths:               ^cstring,
    num_include_paths:           _c.size_t,
    root_folder:                 cstring,
    extra_include_paths_applied: _c.int,
}

key_parse_info_t :: struct {
    file_name:         cstring,
    line_number:       _c.size_t,
    include_paths:     ^cstring,
    num_include_paths: _c.size_t,
    root_folder:       cstring,
}

binout_file :: struct {
    directory:       binout_directory_t,
    files:           rawptr,
    num_files:       _c.size_t,
    file_errors:     ^cstring,
    num_file_errors: _c.size_t,
    error_string:    cstring,
}

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

AnonymousStruct77 :: struct {
    ndim:                          u64,
    numnp:                         u64,
    nglbv:                         u64,
    it:                            u64,
    iu:                            u64,
    iv:                            u64,
    ia:                            u64,
    nummat8:                       u64,
    nv3d:                          u64,
    nel2:                          u64,
    nummat2:                       u64,
    nv1d:                          u64,
    nel4:                          u64,
    nummat4:                       u64,
    nv2d:                          u64,
    neiph:                         u64,
    neips:                         u64,
    nmsph:                         u64,
    narbs:                         u64,
    nelt:                          u64,
    nummatt:                       u64,
    nv3dt:                         u64,
    ioshl:                         [4]u64,
    ialemat:                       [4]u64,
    ncfdv1:                        [4]u64,
    nadapt:                        [4]u64,
    nmmat:                         [4]u64,
    nel48:                         [4]u64,
    nel20:                         [4]u64,
    nt3d:                          [4]u64,
    numrbs:                        u64,
    nel8:                          i64,
    maxint:                        i64,
    mdlopt:                        u8,
    istrn:                         u8,
    plastic_strain_tensor_written: u8,
    thermal_strain_tensor_written: u8,
    element_connectivity_packed:   u8,
}

d3plot_file :: struct {
    control_data:  AnonymousStruct169,
    data_pointers: ^_c.size_t,
    num_states:    _c.size_t,
    buffer:        d3_buffer,
    error_string:  cstring,
}

tm :: struct {}

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
    options:     ^transformation_option_t,
    num_options: _c.size_t,
}

line_reader_t :: struct {
    file:           rawptr,
    line:           extra_string,
    line_length:    _c.size_t,
    comment_index:  _c.size_t,
    buffer:         cstring,
    buffer_index:   _c.size_t,
    bytes_read:     _c.size_t,
    extra_capacity: _c.size_t,
}

AnonymousStruct169 :: struct {
    ndim:                          u64,
    numnp:                         u64,
    nglbv:                         u64,
    it:                            u64,
    iu:                            u64,
    iv:                            u64,
    ia:                            u64,
    nummat8:                       u64,
    nv3d:                          u64,
    nel2:                          u64,
    nummat2:                       u64,
    nv1d:                          u64,
    nel4:                          u64,
    nummat4:                       u64,
    nv2d:                          u64,
    neiph:                         u64,
    neips:                         u64,
    nmsph:                         u64,
    narbs:                         u64,
    nelt:                          u64,
    nummatt:                       u64,
    nv3dt:                         u64,
    ioshl:                         [4]u64,
    ialemat:                       [4]u64,
    ncfdv1:                        [4]u64,
    nadapt:                        [4]u64,
    nmmat:                         [4]u64,
    nel48:                         [4]u64,
    nel20:                         [4]u64,
    nt3d:                          [4]u64,
    numrbs:                        u64,
    nel8:                          i64,
    maxint:                        i64,
    mdlopt:                        u8,
    istrn:                         u8,
    plastic_strain_tensor_written: u8,
    thermal_strain_tensor_written: u8,
    element_connectivity_packed:   u8,
}

AnonymousUnion0 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion1 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion2 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion3 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion4 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion5 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion6 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion7 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion8 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion9 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion10 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion11 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion12 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion13 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion14 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion15 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion16 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion17 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion18 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion19 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion20 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion21 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion22 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion23 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion24 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion25 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion26 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion27 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion28 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion29 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion30 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion31 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion32 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion33 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion34 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion35 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion36 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion37 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion38 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion39 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion40 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion41 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion42 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion43 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion44 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion45 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion46 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion47 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion48 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion49 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion50 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion51 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion52 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion53 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion54 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion55 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion56 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion57 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion58 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion59 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion60 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion61 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion62 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion63 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion64 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion65 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion66 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion67 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion68 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion69 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion70 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion71 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion72 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion73 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion74 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion75 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion76 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion77 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion78 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion79 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion80 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion81 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion82 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion83 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion84 :: struct #raw_union {
    xy: _c.double,
    yx: _c.double,
}

AnonymousUnion85 :: struct #raw_union {
    yz: _c.double,
    zy: _c.double,
}

AnonymousUnion86 :: struct #raw_union {
    zx: _c.double,
    xz: _c.double,
}

AnonymousUnion87 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion88 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion89 :: struct #raw_union {
    epsilon: d3plot_tensor,
    strain:  d3plot_tensor,
}

AnonymousUnion90 :: struct #raw_union {
    sigma:  d3plot_tensor,
    stress: d3plot_tensor,
}

AnonymousUnion91 :: struct #raw_union {
    effective_plastic_strain: _c.double,
    material_dependent_value: _c.double,
}

AnonymousUnion92 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion93 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

AnonymousUnion94 :: struct #raw_union {
    inner_epsilon: d3plot_tensor,
    inner_strain:  d3plot_tensor,
}

AnonymousUnion95 :: struct #raw_union {
    outer_epsilon: d3plot_tensor,
    outer_strain:  d3plot_tensor,
}

@(default_calling_convention = "c")
foreign dynareadout {

    @(link_name = "path_move_up")
    path_move_up :: proc(path: cstring) -> _c.size_t ---

    @(link_name = "path_move_up_real")
    path_move_up_real :: proc(path: cstring) -> _c.size_t ---

    @(link_name = "path_join")
    path_join :: proc(lhs: cstring, rhs: cstring) -> cstring ---

    @(link_name = "path_join_real")
    path_join_real :: proc(lhs: cstring, rhs: cstring) -> cstring ---

    @(link_name = "path_is_file")
    path_is_file :: proc(path_name: cstring) -> _c.int ---

    @(link_name = "path_is_directory")
    path_is_directory :: proc(path_name: cstring) -> _c.int ---

    @(link_name = "path_working_directory")
    path_working_directory :: proc() -> cstring ---

    @(link_name = "path_is_abs")
    path_is_abs :: proc(path_name: cstring) -> _c.int ---

    @(link_name = "path_get_file_size")
    path_get_file_size :: proc(path_name: cstring) -> u64 ---

    @(link_name = "path_view_new")
    path_view_new :: proc(string: cstring) -> path_view_t ---

    @(link_name = "path_view_advance")
    path_view_advance :: proc(pv: ^path_view_t) -> _c.int ---

    @(link_name = "path_view_strcmp")
    path_view_strcmp :: proc(pv: ^path_view_t, str: cstring) -> _c.int ---

    @(link_name = "path_view_stralloc")
    path_view_stralloc :: proc(pv: ^path_view_t) -> cstring ---

    @(link_name = "path_view_print")
    path_view_print :: proc(pv: ^path_view_t) ---

    @(link_name = "binout_directory_insert_folder")
    binout_directory_insert_folder :: proc(dir: ^binout_directory_t, path: ^path_view_t) -> ^binout_folder_t ---

    @(link_name = "binout_folder_insert_folder")
    binout_folder_insert_folder :: proc(dir: ^binout_folder_t, path: ^path_view_t) -> ^binout_folder_t ---

    @(link_name = "binout_folder_insert_file")
    binout_folder_insert_file :: proc(dir: ^binout_folder_t, name: cstring, var_type: u8, size: _c.size_t, file_index: u8, file_pos: _c.long) ---

    @(link_name = "binout_directory_get_file")
    binout_directory_get_file :: proc(dir: ^binout_directory_t, path: ^path_view_t) -> ^binout_file_t ---

    @(link_name = "binout_folder_get_file")
    binout_folder_get_file :: proc(dir: ^binout_folder_t, path: ^path_view_t) -> ^binout_file_t ---

    @(link_name = "binout_directory_get_children")
    binout_directory_get_children :: proc(dir: ^binout_directory_t, path: ^path_view_t, num_children: ^_c.size_t) -> [^]binout_folder_or_file_t ---

    @(link_name = "binout_folder_get_children")
    binout_folder_get_children :: proc(folder: ^binout_folder_t, path: ^path_view_t, num_children: ^_c.size_t) -> [^]binout_folder_or_file_t ---

    @(link_name = "binout_directory_free")
    binout_directory_free :: proc(dir: ^binout_directory_t) ---

    @(link_name = "binout_folder_free")
    binout_folder_free :: proc(folder: ^binout_folder_t) ---

    @(link_name = "extra_string_get")
    extra_string_get :: proc(str: ^extra_string, index: _c.size_t) -> _c.char ---

    @(link_name = "extra_string_set")
    extra_string_set :: proc(str: ^extra_string, index: _c.size_t, value: _c.char) ---

    @(link_name = "extra_string_copy")
    extra_string_copy :: proc(dst: ^extra_string, src: ^extra_string, src_len: _c.size_t, offset: _c.size_t) ---

    @(link_name = "extra_string_copy_to_string")
    extra_string_copy_to_string :: proc(dst: cstring, src: ^extra_string, dst_len: _c.size_t) ---

    @(link_name = "extra_string_compare")
    extra_string_compare :: proc(lhs: ^extra_string, rhs: cstring) -> _c.int ---

    @(link_name = "extra_string_starts_with")
    extra_string_starts_with :: proc(str: ^extra_string, prefix: cstring) -> b32 ---

    @(link_name = "string_builder_new")
    string_builder_new :: proc() -> string_builder_t ---

    @(link_name = "string_builder_append")
    string_builder_append :: proc(b: ^string_builder_t, s: cstring) ---

    @(link_name = "string_builder_append_char")
    string_builder_append_char :: proc(b: ^string_builder_t, c: _c.char) ---

    @(link_name = "string_builder_append_len")
    string_builder_append_len :: proc(b: ^string_builder_t, s: cstring, l: _c.size_t) ---

    @(link_name = "string_builder_move")
    string_builder_move :: proc(b: ^string_builder_t) -> cstring ---

    @(link_name = "string_builder_free")
    string_builder_free :: proc(b: ^string_builder_t) ---

    @(link_name = "string_clone")
    string_clone :: proc(str: cstring) -> cstring ---

    @(link_name = "string_clone_len")
    string_clone_len :: proc(str: cstring, len: _c.size_t) -> cstring ---

    @(link_name = "key_default_parse_config")
    key_default_parse_config :: proc() -> key_parse_config_t ---

    @(link_name = "key_file_parse")
    key_file_parse :: proc(file_name: cstring, num_keywords: ^_c.size_t, parse_config: ^key_parse_config_t, error_string: ^cstring, warning_string: ^cstring) -> [^]keyword_t ---

    @(link_name = "key_file_parse_with_callback")
    key_file_parse_with_callback :: proc(file_name: cstring, callback: key_file_callback, parse_config: ^key_parse_config_t = nil, error_string: ^cstring = nil, warning_string: ^cstring = nil, user_data: rawptr = nil, rec: ^key_parse_recursion_t = nil) ---

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

    @(link_name = "binout_directory_binary_search_folder")
    binout_directory_binary_search_folder :: proc(arr: [^]binout_folder_t, start_index: _c.size_t, end_index: _c.size_t, value: ^path_view_t) -> _c.size_t ---

    @(link_name = "binout_directory_binary_search_folder_insert")
    binout_directory_binary_search_folder_insert :: proc(arr: [^]binout_folder_t, start_index: _c.size_t, end_index: _c.size_t, value: ^path_view_t, found: ^b32) -> _c.size_t ---

    @(link_name = "binout_directory_binary_search_file")
    binout_directory_binary_search_file :: proc(arr: [^]binout_file_t, start_index: _c.size_t, end_index: _c.size_t, value: ^path_view_t) -> _c.size_t ---

    @(link_name = "binout_directory_binary_search_file_insert")
    binout_directory_binary_search_file_insert :: proc(arr: [^]binout_file_t, start_index: _c.size_t, end_index: _c.size_t, value: cstring, found: ^b32) -> _c.size_t ---

    @(link_name = "d3_word_binary_search")
    d3_word_binary_search :: proc(arr: [^]u64, start_index: _c.size_t, end_index: _c.size_t, value: u64) -> _c.size_t ---

    @(link_name = "d3_word_binary_search_insert")
    d3_word_binary_search_insert :: proc(arr: [^]u64, start_index: _c.size_t, end_index: _c.size_t, value: u64, found: ^b32) -> _c.size_t ---

    @(link_name = "key_file_binary_search_insert")
    key_file_binary_search_insert :: proc(arr: [^]keyword_t, start_index: _c.size_t, end_index: _c.size_t, value: cstring, found: ^b32) -> _c.size_t ---

    @(link_name = "key_file_binary_search")
    key_file_binary_search :: proc(arr: [^]keyword_t, start_index: _c.size_t, end_index: _c.size_t, value: cstring) -> _c.size_t ---

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
    binout_get_type_id :: proc(bin_file: ^binout_file, path_to_variable: cstring) -> u8 ---

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
    binout_simple_path_to_real :: proc(bin_file: ^binout_file, simple: cstring, type_id: ^u8, timed: ^b32) -> cstring ---

    @(link_name = "binout_glob")
    binout_glob :: proc(pattern: cstring, num_files: ^_c.size_t) -> [^]cstring ---

    @(link_name = "binout_free_glob")
    binout_free_glob :: proc(globed_files: [^]cstring, num_files: _c.size_t) ---

    @(link_name = "d3plot_open")
    d3plot_open :: proc(root_file_name: cstring) -> d3plot_file ---

    @(link_name = "d3plot_close")
    d3plot_close :: proc(plot_file: ^d3plot_file) ---

    @(link_name = "d3plot_read_node_ids")
    d3plot_read_node_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]u64 ---

    @(link_name = "d3plot_read_solid_element_ids")
    d3plot_read_solid_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]u64 ---

    @(link_name = "d3plot_read_beam_element_ids")
    d3plot_read_beam_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]u64 ---

    @(link_name = "d3plot_read_shell_element_ids")
    d3plot_read_shell_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]u64 ---

    @(link_name = "d3plot_read_thick_shell_element_ids")
    d3plot_read_thick_shell_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]u64 ---

    @(link_name = "d3plot_read_part_ids")
    d3plot_read_part_ids :: proc(plot_file: ^d3plot_file, num_parts: ^_c.size_t) -> [^]u64 ---

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
    d3plot_read_run_time :: proc(plot_file: ^d3plot_file) -> ^tm ---

    @(link_name = "d3plot_read_part")
    d3plot_read_part :: proc(plot_file: ^d3plot_file, part_index: _c.size_t) -> d3plot_part ---

    @(link_name = "d3plot_read_part_by_id")
    d3plot_read_part_by_id :: proc(plot_file: ^d3plot_file, part_id: u64, part_ids: [^]u64 = nil, num_parts: _c.size_t = 0) -> d3plot_part ---

    @(link_name = "d3plot_free_part")
    d3plot_free_part :: proc(part: ^d3plot_part) ---

    @(link_name = "d3plot_free_shells_state")
    d3plot_free_shells_state :: proc(shells: ^d3plot_shell) ---

    @(link_name = "d3plot_free_thick_shells_state")
    d3plot_free_thick_shells_state :: proc(thick_shells: ^d3plot_thick_shell) ---

    @(link_name = "d3plot_read_all_element_ids")
    d3plot_read_all_element_ids :: proc(plot_file: ^d3plot_file, num_ids: ^_c.size_t) -> [^]u64 ---

    @(link_name = "d3plot_index_for_id")
    d3plot_index_for_id :: proc(id: u64, ids: [^]u64, num_ids: _c.size_t) -> _c.size_t ---

    @(link_name = "d3plot_part_get_node_ids2")
    d3plot_part_get_node_ids2 :: proc(plot_file: ^d3plot_file, part: ^d3plot_part, num_part_node_ids: ^_c.size_t, node_ids: [^]u64 = nil, num_nodes: _c.size_t = 0, solid_ids: [^]u64 = nil, num_solids: _c.size_t = 0, beam_ids: [^]u64 = nil, num_beams: _c.size_t = 0, shell_ids: [^]u64 = nil, num_shells: _c.size_t = 0, thick_shell_ids: [^]u64 = nil, num_thick_shells: _c.size_t = 0, solid_cons: [^]d3plot_solid_con = nil, beam_cons: [^]d3plot_beam_con = nil, shell_cons: [^]d3plot_shell_con = nil, thick_shell_cons: [^]d3plot_thick_shell_con = nil) -> [^]u64 ---

    @(link_name = "d3plot_part_get_node_indices2")
    d3plot_part_get_node_indices2 :: proc(plot_file: ^d3plot_file, part: ^d3plot_part, num_part_node_indices: ^_c.size_t, solid_ids: [^]u64 = nil, num_solids: _c.size_t = 0, beam_ids: [^]u64 = nil, num_beams: _c.size_t = 0, shell_ids: [^]u64 = nil, num_shells: _c.size_t = 0, thick_shell_ids: [^]u64 = nil, num_thick_shells: _c.size_t = 0, solid_cons: [^]d3plot_solid_con = nil, beam_cons: [^]d3plot_beam_con = nil, shell_cons: [^]d3plot_shell_con = nil, thick_shell_cons: [^]d3plot_thick_shell_con = nil) -> [^]u64 ---

    @(link_name = "d3plot_part_get_num_nodes2")
    d3plot_part_get_num_nodes2 :: proc(plot_file: ^d3plot_file, part: ^d3plot_part, solid_ids: [^]u64 = nil, num_solids: _c.size_t = 0, beam_ids: [^]u64 = nil, num_beams: _c.size_t = 0, shell_ids: [^]u64 = nil, num_shells: _c.size_t = 0, thick_shell_ids: [^]u64 = nil, num_thick_shells: _c.size_t = 0, solid_cons: [^]d3plot_solid_con = nil, beam_cons: [^]d3plot_beam_con = nil, shell_cons: [^]d3plot_shell_con = nil, thick_shell_cons: [^]d3plot_thick_shell_con = nil) -> _c.size_t ---

    @(link_name = "d3plot_part_get_num_elements")
    d3plot_part_get_num_elements :: proc(part: ^d3plot_part) -> _c.size_t ---

    @(link_name = "d3plot_part_get_all_element_ids")
    d3plot_part_get_all_element_ids :: proc(part: ^d3plot_part, num_ids: ^_c.size_t) -> [^]u64 ---

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

    @(link_name = "_card_try_parse_int")
    card_try_parse_int :: proc(card: ^card_t, value: ^i64) ---

    @(link_name = "_card_try_parse_float64")
    card_try_parse_float64 :: proc(card: ^card_t, value: ^_c.double) ---

    @(link_name = "new_line_reader")
    new_line_reader :: proc(file: rawptr) -> line_reader_t ---

    @(link_name = "read_line")
    read_line :: proc(lr: ^line_reader_t) -> b32 ---

    @(link_name = "free_line_reader")
    free_line_reader :: proc(lr: line_reader_t) ---
}
