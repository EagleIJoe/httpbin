FROM registry.access.redhat.com/ubi8/python-38

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

USER root

# RUN apt update -y && apt install python3-pip git -y && pip3 install --no-cache-dir pipenv

#ADD Pipfile Pipfile.lock /httpbin/
WORKDIR /httpbin
#RUN /bin/bash -c "pip3 install --no-cache-dir -r <(pipenv lock -r)"

ADD . /httpbin
RUN pip3 install --no-cache-dir /httpbin

USER 1001

EXPOSE 8080

CMD ["gunicorn", "-b", "0.0.0.0:880", "httpbin:app", "-k", "gevent"]
