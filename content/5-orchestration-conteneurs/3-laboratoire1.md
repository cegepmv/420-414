Demo: Modelling Scale with Docker Compose

Compose is valid for some production scenarios, but it is limited

Scaling with the CLI
You can scale up and run multiple containers for a component, but only if the component doesn't use restricted resources like ports

This Docker Compose file publishes the stock API to a random host port.

```bash
docker compose up -d
docker compose up -d scale backend=3
```

Browse to http://<IP de votre LXC>:8080, requests from the web to the ecommerce api are load-balanced

```bash
docker compose logs backend
```

But you can't scale containers that publish ports, because ports are an exclusive resource.

```bash
docker compose up scale frontend=3 -d
docker ps -a
```
New frontend container are created but can't start.

This is the other problem with COmpose - it's a client-side component. The server doesn't store the application model, and you need to have the YAML available to manage the app.

Recording scale in the model
The v2.yaml specifies the backend scale, so it's part of the model and you won't accidentally modify the current
```yaml
scale: 3
```
```bash
docker compose -f ./v2.yml up -d
```

We haven't specified a scale setting for my docker‑compose up command, and the default value is 1. So again, Docker Compose has seen the desired state for the frontend component is to have a single container. There are currently three, so it removes two of them to get from the current state to the desired state. So we can see here that Docker Compose is pretty powerful. So inside that YAML file that lives inside your source code repo, you can define the whole structure of your application, and you can bring everything up with a single command. But you need to be aware that Docker Compose is a client‑side tool. It's not a fully fledged container platform because it only works with a single server. So there's a limit to how much scale you can get because you can't run multiple containers listening for the same port, and there's a limit to how much reliability you can get, because if the server goes down, it takes all of your containers with it, and then all of your applications go offline. And in the next clip we'll wrap up the module, and we'll make sure we understand exactly what those limitations of Docker Compose really are.