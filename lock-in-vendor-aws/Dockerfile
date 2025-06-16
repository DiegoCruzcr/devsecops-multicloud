FROM public.ecr.aws/docker/library/python:3.12.11

EXPOSE 5000


WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
