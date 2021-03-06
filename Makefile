help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  test           to perform unit tests"
	@echo "  coverage       to perform unit tests with code coverage"
	@echo "  coverage-show  to show the code coverage report"
	@echo "  clean          to remove build artifacts"
	@echo "  tag            to modify the version"
	@echo "  package        to build the phar and zip files"

test:
	vendor/bin/phpunit

coverage:
	vendor/bin/phpunit --coverage-html=build/artifacts/coverage

coverage-show:
	open build/artifacts/coverage/index.html

clean:
	rm -rf build/artifacts

tag:
	$(if $(TAG),,$(error TAG is not defined. Pass via "make tag TAG=0.1.2"))
	@echo Tagging $(TAG)
	sed -i '' -e "s/@version .*/@version $(TAG)/" src/*.php
	sed -i '' -e "s/@version .*/@version $(TAG)/" src/**/*.php

package:
	php build/packager.php

.PHONY: test coverage coverage-show clean package
