# sleuth_docker


To run the container:
- `docker pull trevormeiss/sleuth_docker`
- `docker run -it --rm trevormeiss/sleuth_docker`

To test the container:
- `cd test`
- `RUN CMD BATCH test.R test.out`
  - Warning: this will create files in excess of 8GB.
