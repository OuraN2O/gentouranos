# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="${PV/_beta/beta}"  # Transforme 25.01_beta1 en 25.01beta1
PYTHON_COMPAT=( python3_{10..13} )
CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aes@0.8.4
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	ammonia@4.0.0
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.18
	anstyle@1.0.10
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anyhow@1.0.95
	apple-bundles@0.17.0
	arrayref@0.3.9
	arrayvec@0.7.6
	ash@0.37.3+1.3.251
	assert-json-diff@2.0.2
	async-compression@0.4.18
	async-stream@0.3.6
	async-stream-impl@0.3.6
	async-trait@0.1.85
	atomic-waker@1.1.2
	autocfg@1.4.0
	axum@0.7.9
	axum-client-ip@0.6.1
	axum-core@0.4.5
	axum-extra@0.9.6
	axum-macros@0.4.2
	backtrace@0.3.74
	base64@0.13.1
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bincode@2.0.0-rc.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.8.0
	blake3@1.5.5
	block@0.1.6
	block-buffer@0.10.4
	block-padding@0.3.3
	bstr@1.11.3
	bumpalo@3.16.0
	burn@0.13.2
	burn-autodiff@0.13.2
	burn-candle@0.13.2
	burn-common@0.13.2
	burn-compute@0.13.2
	burn-core@0.13.2
	burn-dataset@0.13.2
	burn-derive@0.13.2
	burn-fusion@0.13.2
	burn-jit@0.13.2
	burn-ndarray@0.13.2
	burn-tch@0.13.2
	burn-tensor@0.13.2
	burn-train@0.13.2
	burn-wgpu@0.13.2
	bytemuck@1.21.0
	bytemuck_derive@1.8.1
	byteorder@1.5.0
	bytes@1.9.0
	bzip2@0.4.4
	bzip2-sys@0.1.11+1.0.8
	camino@1.1.9
	candle-core@0.4.1
	cbc@0.1.2
	cc@1.2.10
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	cfg_aliases@0.2.1
	chrono@0.4.39
	cipher@0.4.4
	clap@4.5.26
	clap_builder@4.5.26
	clap_complete@4.5.42
	clap_derive@4.5.24
	clap_lex@0.7.4
	coarsetime@0.1.35
	codespan@0.11.1
	codespan-reporting@0.11.1
	color_quant@1.1.0
	colorchoice@1.0.3
	com@0.6.0
	com_macros@0.6.0
	com_macros_support@0.6.0
	constant_time_eq@0.1.5
	constant_time_eq@0.3.1
	convert_case@0.6.0
	core-foundation@0.9.4
	core-foundation@0.10.0
	core-foundation-sys@0.8.7
	core-graphics-types@0.1.3
	cpufeatures@0.2.16
	crc32fast@1.4.2
	crossbeam-channel@0.5.14
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.2
	crypto-common@0.1.6
	csv@1.3.1
	csv-core@0.1.11
	d3d12@0.19.0
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	dashmap@5.5.3
	data-encoding@2.7.0
	dbus@0.9.7
	deadpool@0.10.0
	deadpool-runtime@0.1.4
	deranged@0.3.11
	derive-new@0.6.0
	derive_builder@0.20.2
	derive_builder_core@0.20.2
	derive_builder_macro@0.20.2
	des@0.8.1
	difflib@0.4.0
	digest@0.10.7
	dirs@5.0.1
	dirs-sys@0.4.1
	displaydoc@0.2.5
	duct@0.13.7
	dunce@1.0.5
	dyn-stack@0.10.0
	either@1.13.0
	elasticlunr-rs@3.0.2
	encoding_rs@0.8.35
	enum-as-inner@0.6.1
	env_filter@0.1.3
	env_logger@0.11.6
	envy@0.4.2
	equivalent@1.0.1
	errno@0.3.10
	exr@1.73.0
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	faster-hex@0.9.0
	fastrand@2.3.0
	fdeflate@0.3.7
	filetime@0.2.25
	find-winsdk@0.2.0
	fixedbitset@0.4.2
	flate2@1.0.35
	fluent@0.16.1
	fluent-bundle@0.15.3
	fluent-langneg@0.13.0
	fluent-syntax@0.11.1
	fnv@1.0.7
	foreign-types@0.3.2
	foreign-types@0.5.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.1.1
	foreign-types-shared@0.3.1
	form_urlencoded@1.2.1
	forwarded-header-value@0.1.1
	fs2@0.4.3
	fsevent-sys@4.1.0
	fsrs@2.0.0
	futf@0.1.5
	futures@0.3.31
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-intrusive@0.5.0
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	gemm@0.17.1
	gemm-c32@0.17.1
	gemm-c64@0.17.1
	gemm-common@0.17.1
	gemm-f16@0.17.1
	gemm-f32@0.17.1
	gemm-f64@0.17.1
	generic-array@0.14.7
	getopts@0.2.21
	getrandom@0.2.15
	gif@0.13.1
	gimli@0.31.1
	gix-features@0.36.1
	gix-fs@0.8.1
	gix-hash@0.13.3
	gix-tempfile@11.0.1
	gix-trace@0.1.12
	gl_generator@0.14.0
	glob@0.3.2
	globset@0.4.15
	glow@0.13.1
	glutin_wgl_sys@0.5.0
	gpu-alloc@0.6.0
	gpu-alloc-types@0.3.0
	gpu-allocator@0.25.0
	gpu-descriptor@0.2.4
	gpu-descriptor-types@0.1.2
	h2@0.3.26
	h2@0.4.7
	half@2.4.1
	handlebars@6.3.0
	hashbrown@0.13.2
	hashbrown@0.14.5
	hashbrown@0.15.2
	hashlink@0.8.4
	hassle-rs@0.11.0
	headers@0.3.9
	headers@0.4.0
	headers-core@0.2.0
	headers-core@0.3.0
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	hexf-parse@0.2.1
	hmac@0.12.1
	home@0.5.11
	html5ever@0.26.0
	html5ever@0.27.0
	htmlescape@0.3.1
	http@0.2.12
	http@1.2.0
	http-body@0.4.6
	http-body@1.0.1
	http-body-util@0.1.2
	httparse@1.9.5
	httpdate@1.0.3
	humantime@2.1.0
	hyper@0.14.32
	hyper@1.5.2
	hyper-rustls@0.24.2
	hyper-rustls@0.27.5
	hyper-tls@0.5.0
	hyper-tls@0.6.0
	hyper-util@0.1.10
	iana-time-zone@0.1.61
	iana-time-zone-haiku@0.1.2
	icu_collections@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.0
	icu_normalizer@1.5.0
	icu_normalizer_data@1.5.0
	icu_properties@1.5.1
	icu_properties_data@1.5.0
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	id_tree@1.8.0
	ident_case@1.0.1
	idna@1.0.3
	idna_adapter@1.2.0
	ignore@0.4.23
	image@0.24.9
	indexmap@2.7.0
	indoc@2.0.5
	inflections@1.1.1
	inotify@0.9.6
	inotify-sys@0.1.5
	inout@0.1.3
	intl-memoizer@0.5.2
	intl_pluralrules@7.0.2
	ipnet@2.10.1
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.14
	jni-sys@0.3.0
	jobserver@0.1.32
	jpeg-decoder@0.3.1
	js-sys@0.3.77
	junction@1.2.0
	khronos-egl@6.0.0
	khronos_api@3.1.0
	kqueue@1.0.8
	kqueue-sys@1.0.4
	lazy_static@1.5.0
	lebe@0.5.2
	libc@0.2.169
	libdbus-sys@0.2.5
	libloading@0.7.4
	libloading@0.8.6
	libm@0.2.11
	libredox@0.1.3
	libsqlite3-sys@0.27.0
	linkcheck@0.4.1
	linkify@0.7.0
	linux-raw-sys@0.4.15
	litemap@0.7.4
	lock_api@0.4.12
	log@0.4.25
	lzma-sys@0.1.20
	mac@0.1.1
	malloc_buf@0.0.6
	maplit@1.0.2
	markup5ever@0.11.0
	markup5ever@0.12.1
	markup5ever_rcdom@0.2.0
	matchers@0.1.0
	matches@0.1.10
	matchit@0.7.3
	matrixmultiply@0.3.9
	md5@0.7.0
	mdbook@0.4.43
	memchr@2.7.4
	memmap2@0.9.5
	memoffset@0.9.1
	metal@0.27.0
	mime@0.3.17
	mime_guess@2.0.5
	minimal-lexical@0.2.1
	miniz_oxide@0.8.3
	mio@0.8.11
	mio@1.0.3
	multer@3.1.0
	multimap@0.10.0
	naga@0.19.2
	native-tls@0.2.12
	ndarray@0.15.6
	ndarray-rand@0.14.0
	ndk-sys@0.5.0+25.2.9519653
	new_debug_unreachable@1.0.6
	nom@7.1.3
	nonempty@0.7.0
	normpath@1.3.0
	notify@6.1.1
	notify-debouncer-mini@0.4.1
	nu-ansi-term@0.46.0
	num-complex@0.4.6
	num-conv@0.1.0
	num-format@0.4.4
	num-integer@0.1.46
	num-modular@0.6.1
	num-order@1.2.0
	num-traits@0.2.19
	num_cpus@1.16.0
	num_enum@0.7.3
	num_enum_derive@0.7.3
	objc@0.2.7
	objc_exception@0.1.2
	object@0.36.7
	once_cell@1.20.2
	opener@0.7.2
	openssl@0.10.68
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.104
	option-ext@0.2.0
	os_pipe@1.2.1
	overload@0.1.1
	p12@0.6.3
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	password-hash@0.4.2
	password-hash@0.5.0
	paste@1.0.15
	pathdiff@0.2.3
	pbkdf2@0.11.0
	pbkdf2@0.12.2
	pem@1.1.1
	percent-encoding@2.3.1
	pest@2.7.15
	pest_derive@2.7.15
	pest_generator@2.7.15
	pest_meta@2.7.15
	petgraph@0.6.5
	phf@0.10.1
	phf@0.11.3
	phf_codegen@0.10.0
	phf_codegen@0.11.3
	phf_generator@0.10.0
	phf_generator@0.11.3
	phf_macros@0.11.3
	phf_shared@0.10.0
	phf_shared@0.11.3
	pin-project@1.1.8
	pin-project-internal@1.1.8
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.31
	plist@1.7.0
	png@0.17.16
	pollster@0.3.0
	portable-atomic@1.10.0
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	precomputed-hash@0.1.1
	presser@0.3.1
	prettyplease@0.2.29
	priority-queue@2.1.1
	proc-macro-crate@3.2.0
	proc-macro-hack@0.5.20+deprecated
	proc-macro2@1.0.93
	profiling@1.0.16
	prost@0.13.4
	prost-build@0.13.4
	prost-derive@0.13.4
	prost-reflect@0.14.4
	prost-types@0.13.4
	pulldown-cmark@0.8.0
	pulldown-cmark@0.9.6
	pulldown-cmark@0.10.3
	pulldown-cmark-escape@0.10.1
	pulp@0.18.22
	pyo3@0.22.6
	pyo3-build-config@0.22.6
	pyo3-ffi@0.22.6
	pyo3-macros@0.22.6
	pyo3-macros-backend@0.22.6
	qoi@0.4.1
	quick-xml@0.32.0
	quinn@0.11.6
	quinn-proto@0.11.9
	quinn-udp@0.5.9
	quote@1.0.38
	r2d2@0.8.10
	r2d2_sqlite@0.23.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_distr@0.4.3
	range-alloc@0.1.4
	raw-cpuid@10.7.0
	raw-window-handle@0.6.2
	rawpointer@0.2.1
	rayon@1.10.0
	rayon-core@1.12.1
	rc2@0.8.1
	rcgen@0.10.0
	reborrow@0.5.5
	redox_syscall@0.5.8
	redox_users@0.4.6
	regex@1.11.1
	regex-automata@0.1.10
	regex-automata@0.4.9
	regex-syntax@0.6.29
	regex-syntax@0.8.5
	renderdoc-sys@1.1.0
	reqwest@0.11.27
	reqwest@0.12.12
	ring@0.16.20
	ring@0.17.8
	rmp@0.8.14
	rmp-serde@1.3.0
	rusqlite@0.30.0
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustc-hash@2.1.0
	rustix@0.38.43
	rustls@0.21.12
	rustls@0.23.21
	rustls-native-certs@0.8.1
	rustls-pemfile@1.0.4
	rustls-pemfile@2.2.0
	rustls-pki-types@1.10.1
	rustls-webpki@0.101.7
	rustls-webpki@0.102.8
	rustversion@1.0.19
	ryu@1.0.18
	safetensors@0.3.3
	safetensors@0.4.5
	same-file@1.0.6
	sanitize-filename@0.5.0
	schannel@0.1.27
	scheduled-thread-pool@0.2.7
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	security-framework@2.11.1
	security-framework@3.2.0
	security-framework-sys@2.14.0
	self_cell@0.10.3
	self_cell@1.1.0
	semver@1.0.25
	seq-macro@0.3.5
	serde@1.0.217
	serde-aux@4.5.0
	serde_derive@1.0.217
	serde_json@1.0.137
	serde_path_to_error@0.1.16
	serde_repr@0.1.19
	serde_rusqlite@0.34.0
	serde_tuple@0.5.0
	serde_tuple_macros@0.5.0
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.8
	sharded-slab@0.1.7
	shared_child@1.0.1
	shlex@1.3.0
	signal-hook@0.3.17
	signal-hook-registry@1.4.2
	simd-adler32@0.3.7
	simple-file-manifest@0.11.0
	siphasher@0.3.11
	siphasher@1.0.1
	slab@0.4.9
	slotmap@1.0.7
	smallvec@1.13.2
	snafu@0.8.5
	snafu-derive@0.8.5
	snowflake@1.3.0
	socket2@0.5.8
	spin@0.5.2
	spin@0.9.8
	spirv@0.3.0+sdk-1.3.268.0
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	strsim@0.11.1
	strum@0.25.0
	strum@0.26.3
	strum_macros@0.25.3
	strum_macros@0.26.4
	subtle@2.6.1
	syn@1.0.109
	syn@2.0.96
	sync_wrapper@0.1.2
	sync_wrapper@1.0.2
	synstructure@0.13.1
	sysctl@0.5.5
	system-configuration@0.5.1
	system-configuration-sys@0.5.0
	tar@0.4.43
	target-lexicon@0.12.16
	tch@0.15.0
	tempfile@3.15.0
	tendril@0.4.3
	termcolor@1.4.1
	terminal_size@0.4.1
	text_placeholder@0.5.1
	thiserror@1.0.69
	thiserror@2.0.11
	thiserror-impl@1.0.69
	thiserror-impl@2.0.11
	thread-tree@0.3.3
	thread_local@1.1.8
	tiff@0.9.1
	time@0.3.37
	time-core@0.1.2
	time-macros@0.2.19
	tinystr@0.7.6
	tinyvec@1.8.1
	tinyvec_macros@0.1.1
	tokio@1.43.0
	tokio-macros@2.5.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-rustls@0.26.1
	tokio-socks@0.5.2
	tokio-tungstenite@0.21.0
	tokio-util@0.7.13
	toml@0.5.11
	toml_datetime@0.6.8
	toml_edit@0.22.22
	topological-sort@0.2.2
	torch-sys@0.15.0
	tower@0.5.2
	tower-http@0.5.2
	tower-layer@0.3.3
	tower-service@0.3.3
	tracing@0.1.41
	tracing-appender@0.2.3
	tracing-attributes@0.1.28
	tracing-core@0.1.33
	tracing-log@0.2.0
	tracing-subscriber@0.3.19
	try-lock@0.2.5
	tugger-common@0.10.0
	tugger-windows@0.10.0
	tugger-windows-codesign@0.10.0
	tungstenite@0.21.0
	type-map@0.5.0
	typenum@1.17.0
	ucd-trie@0.1.7
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-langid@0.9.5
	unic-langid-impl@0.9.5
	unic-langid-macros@0.9.5
	unic-langid-macros-impl@0.9.5
	unic-ucd-category@0.9.0
	unic-ucd-version@0.9.0
	unicase@2.6.0
	unicode-ident@1.0.14
	unicode-normalization@0.1.24
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	unicode-xid@0.2.6
	unindent@0.2.3
	untrusted@0.7.1
	untrusted@0.9.0
	ureq@2.12.1
	url@2.5.4
	utf-8@0.7.6
	utf16_iter@1.0.5
	utf8_iter@1.0.4
	utf8parse@0.2.2
	uuid@1.12.0
	valuable@0.1.1
	vcpkg@0.2.15
	version_check@0.9.5
	walkdir@2.5.0
	want@0.3.1
	warp@0.3.7
	wasi@0.11.0+wasi-snapshot-preview1
	wasix@0.12.21
	wasm-bindgen@0.2.100
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-futures@0.4.50
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-streams@0.4.2
	web-sys@0.3.77
	web-time@1.1.0
	webpki-roots@0.25.4
	webpki-roots@0.26.7
	weezl@0.1.8
	wgpu@0.19.4
	wgpu-core@0.19.4
	wgpu-hal@0.19.5
	wgpu-types@0.19.2
	which@5.0.0
	widestring@1.1.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.52.0
	windows@0.56.0
	windows-core@0.52.0
	windows-core@0.56.0
	windows-implement@0.56.0
	windows-interface@0.56.0
	windows-registry@0.2.0
	windows-result@0.1.2
	windows-result@0.2.0
	windows-strings@0.1.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.6.24
	winreg@0.5.1
	winreg@0.50.0
	wiremock@0.6.2
	write16@1.0.0
	writeable@0.5.5
	xattr@1.4.0
	xml-rs@0.8.25
	xml5ever@0.17.0
	xz2@0.1.7
	yasna@0.5.2
	yoke@0.7.5
	yoke-derive@0.7.5
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
	zerofrom@0.1.5
	zerofrom-derive@0.1.5
	zeroize@1.8.1
	zerovec@0.10.4
	zerovec-derive@0.10.3
	zip@0.6.6
	zstd@0.11.2+zstd.1.5.2
	zstd@0.13.2
	zstd-safe@5.0.2+zstd.1.5.2
	zstd-safe@7.2.1
	zstd-sys@2.0.13+zstd.1.5.6
	zune-inflate@0.2.54
"
declare -A GIT_CRATES=(
	[linkcheck]='https://github.com/ankitects/linkcheck;184b2ca50ed39ca43da13f0b830a463861adb9ca;linkcheck-%commit%'
	[percent-encoding-iri]='https://github.com/ankitects/rust-url;bb930b8d089f4d30d7d19c12e54e66191de47b88;rust-url-%commit%/percent_encoding'
)
RUST_MIN_VER="1.80.1"

inherit cargo desktop edo multiprocessing ninja-utils optfeature \
	python-single-r1 readme.gentoo-r1 toolchain-funcs xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"

# Don't forget to update COMMITS if PV changes.
# Update [node_modules] to the most recent commit hash until ${PV}, that
# changed yarn.lock.
# Oftentimes this file does not change between releases. This versioning
# scheme prevents unnecessary downloads of the (sizeable) node_modules
# folder.
declare -A COMMITS=(
	[anki]="87ccd24efd0ea635558b1679614b6763e4f514eb"
	[ftl-core]="0d0d97e01a56e3dcd2cc2dd20f0bd17b4c05bcdc"
	[ftl-desktop]="e0f9724f75f6248f4e74558b25c3182d4f348bce"
	[node_modules]="2c1a4895ba6d21233cbb4efdc43b0d4961c713a5"
)
SRC_URI="${CARGO_CRATE_URIS}
	https://github.com/ankitects/anki/archive/refs/tags/${MYPV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/ankitects/anki-core-i18n/archive/${COMMITS[ftl-core]}.tar.gz
	-> anki-core-i18n-${COMMITS[ftl-core]}.gh.tar.gz
	https://github.com/ankitects/anki-desktop-ftl/archive/${COMMITS[ftl-desktop]}.tar.gz
	-> anki-desktop-ftl-${COMMITS[ftl-desktop]}.gh.tar.gz
	gui? ( https://git.sr.ht/~antecrescent/gentoo-files/blob/main/app-misc/anki/anki-node_modules-${COMMITS[node_modules]}.tar.xz )
"

S="${WORKDIR}/anki-${MYPV}" # Redirige le répertoire vers le bon (normalement) chemin

PATCHES=(
	"${FILESDIR}"/24.06.3/ninja-gentoo-setup.patch
	"${FILESDIR}"/24.06.3/remove-yarn.patch
	"${FILESDIR}"/24.04.1/remove-mypy-protobuf.patch
	"${FILESDIR}"/24.04.1/revert-cert-store-hack.patch
	"${FILESDIR}"/23.12.1/ninja-rules-for-cargo.patch
	"${FILESDIR}"/23.12.1/remove-formatter-dep.patch
)

# How to get an up-to-date summary of runtime JS libs' licenses:
# ./node_modules/.bin/license-checker-rseidelsohn --production --excludePackages anki --summary
LICENSE="AGPL-3+ BSD public-domain gui? ( 0BSD CC-BY-4.0 GPL-3+ Unlicense )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC0-1.0 ISC MIT
	MPL-2.0 Unicode-3.0 Unicode-DFS-2016 ZLIB
"
# Manually added crate licenses
LICENSE+=" openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc +gui test"
REQUIRED_USE="gui? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!gui? ( test ) !test? ( test )"

# Dependencies:
# Python: python/requirements.{anki,aqt}.in
# If ENABLE_QT5_COMPAT is set at runtime
# additionally depend on PyQt6[dbus,printsupport].
# Qt: qt/{aqt/{sound.py,qt/*.py},tools/build_ui.py}
# app-misc/certificates: The rust backend library is built against
# rustls-native-certs to use the native certificate store.

DEPEND="
	>=app-arch/zstd-1.5.5:=
	dev-db/sqlite:3
"
GUI_RDEPEND="
	${PYTHON_DEPS}
	dev-qt/qtsvg:6
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/decorator[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/protobuf[${PYTHON_USEDEP}]
		>=dev-python/pyqt6-6.6.1[gui,network,opengl,quick,webchannel,widgets,${PYTHON_USEDEP}]
		>=dev-python/pyqt6-sip-13.6.0[${PYTHON_USEDEP}]
		>=dev-python/pyqt6-webengine-6.6.0[widgets,${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/send2trash[${PYTHON_USEDEP}]
		dev-python/waitress[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
	app-misc/ca-certificates
	gui? ( ${GUI_RDEPEND} )
"

BDEPEND="
	>=app-arch/zstd-1.5.5:=
	dev-libs/protobuf[protoc(+)]
	virtual/pkgconfig
	doc? (
		$(python_gen_cond_dep '
			>=dev-python/sphinx-7.2.6[${PYTHON_USEDEP}]
			dev-python/sphinx-autoapi[${PYTHON_USEDEP}]
			dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		')
	)
	gui? (
		${PYTHON_DEPS}
		app-alternatives/ninja
		app-arch/unzip
		>=net-libs/nodejs-20.12.1
		sys-apps/yarn
		$(python_gen_cond_dep '
			dev-python/pyqt6[${PYTHON_USEDEP}]
			dev-python/wheel[${PYTHON_USEDEP}]
		')
	)
	test? (
		${RDEPEND}
		app-text/dvipng
		app-text/texlive
		dev-libs/openssl
		dev-util/cargo-nextest
		$(python_gen_cond_dep '
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		')
	)
"

QA_FLAGS_IGNORED="usr/bin/anki-sync-server
	usr/lib/python.*/site-packages/anki/_rsbridge.so"

pkg_setup() {
	export PROTOC_BINARY="${BROOT}"/usr/bin/protoc
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	export ZSTD_SYS_USE_PKG_CONFIG=1

	if use gui; then
		python-single-r1_pkg_setup
		export NODE_BINARY="${BROOT}"/usr/bin/node
		export YARN_BINARY="${BROOT}"/usr/bin/yarn
#		export OFFLINE_BUILD=0
		if ! use debug; then
			if tc-is-lto; then
				export RELEASE=2
			else
				export RELEASE=1
			fi
		fi
	fi
	rust_pkg_setup
}

src_prepare() {
	default
	rm -r ftl/{core,qt}-repo || die
	ln -s "${WORKDIR}"/anki-core-i18n-${COMMITS[ftl-core]} ftl/core-repo || die
	ln -s "${WORKDIR}"/anki-desktop-ftl-${COMMITS[ftl-desktop]} ftl/qt-repo || die

	mkdir out || die
	echo -e "${COMMITS[anki]:0:8}" > out/buildhash || die
	if use gui; then
		mv "${WORKDIR}"/node_modules out || die

		# Some parts of the runner build system expect to be in a git repository
		mkdir .git || die

		# Creating the pseudo venv early skips pip dependency checks in src_configure.
		mkdir -p out/pyenv/bin || die
		ln -s "${PYTHON}" out/pyenv/bin/python || die
		# TODO: ln -s "${BROOT}/usr/bin/protoc-gen-mypy" out/pyenv/bin || die
		if use doc; then
			ln -s "${BROOT}"/usr/bin/sphinx-apidoc out/pyenv/bin || die
			ln -s "${BROOT}"/usr/bin/sphinx-build out/pyenv/bin || die
		fi

		# Fix hardcoded runner location
		export CARGO_TARGET_DIR="${S}"/out/rust
		cbuild_dir="$(CHOST=${CBUILD:-${CHOST}} cargo_target_dir)"
		sed "s,rust/release,${cbuild_dir##*out/}," \
			-i build/ninja_gen/src/render.rs || die

		# Separate src_configure from runner build
		sed '/ConfigureBuild/d' -i build/ninja_gen/src/build.rs || die
	fi
}

_cbuild_cargo_build() {
	CHOST=${CBUILD:-${CHOST}} cargo_src_compile "${@}"
}

src_configure() {
	cargo_src_configure
	if use gui; then
		tc-env_build _cbuild_cargo_build -p configure
		cargo_env edo "${cbuild_dir}"/configure
	fi
}

src_compile() {
	if use gui; then
		MY_RUNNER="cargo_env edo ${cbuild_dir}/runner build -- $(get_NINJAOPTS)"
		unset cbuild_dir

		tc-env_build _cbuild_cargo_build -p runner
		${MY_RUNNER} wheels
		use doc && ${MY_RUNNER} python:sphinx
	else
		cargo_src_compile --package anki-sync-server
	fi
}

src_test() {
	ln -s "${BROOT}"/usr/bin/pytest out/pyenv/bin/pytest || die
	mkdir out/bin || die
	ln -s "${BROOT}"/usr/bin/cargo-nextest out/bin/cargo-nextest || die

	local nextest_opts=(
		cargo-verbose
		failure-output=immediate
		status-level=all
		test-threads=$(get_makeopts_jobs)
	)
	# cargo-nextest respects Cargo's CARGO_TERM_COLOR variable
	if [[ ! ${CARGO_TERM_COLOR} ]]; then
		[[ "${NOCOLOR}" = true || "${NOCOLOR}" = yes ]] && nextest_opts+=( color=never )
	fi

	nextest_opts=( ${nextest_opts[@]/#/--} )
	# Override hardcoded cargo-nextest options
	sed -i -e "s/\(cargo nextest run\).*\\$/\1 ${nextest_opts[*]} \\$/" \
		"${S}"/build/ninja_gen/src/cargo.rs || die

	local runner
	for runner in pytest rust_test vitest; do
		${MY_RUNNER} check:${runner}
	done
}

src_install() {
	local DOC_CONTENTS="Users with add-ons that still rely on Anki's Qt5 GUI
	can temporarily set the environment variable ENABLE_QT5_COMPAT to 1 to have
	Anki install the previous compatibility code. This option has additional
	runtime dependencies. Please take a look at this package's optional runtime
	features for a complete listing.
	\n\nENABLE_QT5_COMPAT may be removed in the future, so this is not a
	long-term solution.
	\n\nAnki's user manual is located online at https://docs.ankiweb.net/
	\nAnki's add-on developer manual is located online at
	https://addon-docs.ankiweb.net/"

	readme.gentoo_create_doc
	if use gui; then
		pushd qt/bundle/lin > /dev/null || die
		doman anki.1
		doicon anki.{png,xpm}
		domenu anki.desktop
		insinto /usr/share/mime/packages
		doins anki.xml
		popd || die
		use doc && dodoc -r out/python/sphinx/html

		local w
		for w in out/wheels/*.whl; do
			unzip "${w}" -d out/wheels || die
		done
		python_domodule out/wheels/{anki,{,_}aqt,*.dist-info}
		printf "#!/usr/bin/python3\nimport sys;from aqt import run;sys.exit(run())" > runanki || die
		python_newscript runanki anki
	else
		cargo_src_install --path rslib/sync
	fi
}

pkg_postinst() {
	ver_test ${REPLACING_VERSIONS} -lt 24.06.3-r1 && local FORCE_PRINT_ELOG=1
	readme.gentoo_print_elog
	if use gui; then
		xdg_pkg_postinst
		optfeature "LaTeX in cards" "app-text/texlive[extra] app-text/dvipng"
		optfeature "sound support" media-video/mpv media-video/mplayer
		optfeature "recording support" "media-sound/lame[frontend] dev-python/pyqt6[multimedia]"
		optfeature "faster database operations" dev-python/orjson
		optfeature "compatibility with Qt5-dependent add-ons" dev-python/pyqt6[dbus,printsupport]
		optfeature "Vulkan driver" "media-libs/vulkan-loader dev-qt/qtbase:6[vulkan]
			dev-qt/qtdeclarative:6[vulkan] dev-qt/qtwebengine:6[vulkan]"

		einfo "You can customize the LaTeX header for your cards to fit your needs:"
		einfo "Notes > Manage Note Types > [select a note type] > Options"
	fi
}

