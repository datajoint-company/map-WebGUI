## How to build and develop using the new dockerrized app.

To be 100% sure of the new build to be reflected - use below
`docker-compose -f docker-compose-dev.yml build --no-cache`

Then,
`docker-compose -f docker-compose-dev.yml up`
to begin the development in `ng serve` mode - go to
localhost:9000 to see the site.
`docker-compose -f docker-compose-dev.yml down`
when done developing.

For casual re-build/up process
`docker-compose -f docker-compose-dev.yml up --build`

For detached mode and to add log after the fact
`docker-compose -f docker-compose-dev.yml up -d`
`docker-compose -f docker-compose-dev.yml logs -f`

To see the production build using `ng build --prod`,
do the regular docker-compose up then go to localhost:8080
`docker-compose up --build`

to check inside docker 
`docker-compose -f docker-compose-dev.yml exec map-node-server /bin/bash`

--------------------------------
for deploy (general)

Before building, make sure `build: ./map-frontend` is UNcommented in docker-compose.yml.
`docker-compose build map-WebGUI` once that's built,
`docker push registry.vathes.com/map-WebGUI/frontend:v0.0`

commentout the `build: ./map-frontend`

repeat for other 3 `mapapi` `node-server` `nginx` and push to appropriate directory. Update the tags accordingly as well.

for testdev deploy
comment out test/* directory in `.dockerignore` (until proper storage solution is in place)
for test dev mode, make sure `STAGING=true` for nginx > environment setting.
comment out the test/* directory in `.dockerignore`
switch to the `-k` flag line CMD in Dockerfile for nginx

`ssh testdev` go to `map-WebGUI`
`docker-compose down` to stop what's already running
`git pull origin dev` to get the latest from `vathes/map-WebGUI` repo.
make sure to move over to the `dev` branch by `git checkout dev`
`docker login registry.vathes.com` to docker to get access.
`docker-compose pull` to get the map-WebGUI container
`docker-compose up --build -d`

-----------------------------------

for real deploy
for client deploy mode, comment out `STAGING=true` for nginx > environment setting.
MAKE SURE the test/* directory in `.dockerignore` is NOT commented out (test/ directory needs to be ignored!).
switch to the line without the `-k` flag CMD in Dockerfile for nginx

`ssh djcompute` go to `nagivator-deployer/map-WebGUI`
`docker-compose down` to stop what's already running
`git pull origin master` to get the latest from `vathes/map-WebGUI` repo.
`docker login registry.vathes.com` to docker to get access.
`docker-compose pull` to get the map-WebGUI container
`docker-compose up --build -d`

-------------------------------------
