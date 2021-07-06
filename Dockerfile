FROM 353605023268.dkr.ecr.us-east-1.amazonaws.com/python_tox:latest

WORKDIR /src/

COPY . .

# We need to run tests as non-root user,
# because some tests spawn celery workers that cannot be run as root
# Base image runs everything as root, including pyenv
# so here's the hack
RUN useradd tester && chmod -R 775 /root && chown -R tester:tester /root/.pyenv /src

USER tester

CMD ["tox", "-vv"]
