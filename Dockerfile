FROM node:10-slim

WORKDIR .

COPY index.js .

CMD ["node", "index.js"]