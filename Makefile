
watch:
	goconvey -cover -excludedDirs testdata

test:
	go test -v

bench:
	go test -bench=. -run=XXX

doc:
	@echo "Doc server address: http://localhost:6060"
	godoc -http=":6060" -goroot=$$GOPATH

release:
	@if [[ ! "${V}" =~ ^[0-9]+\.[0-9]+\.[0-9]+.*$$ ]]; then echo "Usage: make release V=X.X.X"; exit 1; fi
	go mod tidy
	make test
	@if [ -n "`git status -s`" ]; then echo "\n\nThere are pending changes. Please commit first"; exit 1; fi
	git tag v${V}
	git push origin v${V}
	git push origin master
