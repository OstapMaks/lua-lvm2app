-- Copyright (c) 2012 by Christian Wiese <chris@opensde.org>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

--
-- Generic LVM handling
--

object "LVM" {
	userdata_type = 'simple',
	c_source [[
typedef lvm_t LVM;
]],
	constructor "init" {
		var_in { "const char *", "system_dir", is_optional = true, default = NULL },
		c_call "LVM" "lvm_init" { "const char *", "system_dir" },
	},
	destructor "quit" {
		c_method_call "void" "lvm_quit" {},
	},
	method "config_reload" {
		c_method_call "int" "lvm_config_reload" {}
	},
	method "config_override" {
		c_method_call "int" "lvm_config_override" { "const char *", "config_string" }
	},
	method "errno" {
		c_method_call "int" "lvm_errno" {}
	},
	method "errmsg" {
		c_method_call "const char *" "lvm_errmsg" {}
	},
	method "scan" {
		c_method_call "int" "lvm_scan" {},
	},

	--
	-- TODO: struct dm_list *lvm_list_vg_names(lvm_t libh);
	--

	--
	-- TODO: struct dm_list *lvm_list_vg_uuids(lvm_t libh);
	--

	method "vgname_from_pvid" {
		c_method_call "const char *" "lvm_vgname_from_pvid" { "const char *", "pvid" },
	},
	method "vgname_from_device" {
		c_method_call "const char *" "lvm_vgname_from_device" { "const char *", "device" },
	},
}

