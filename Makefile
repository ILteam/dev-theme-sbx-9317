all: probe

probe:
	@bash ./probe.sh || true

test: probe
