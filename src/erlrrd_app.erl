-module(erlrrd_app).

-export([start/0, stop/0]).
-behavior(application).
-export([start/2, stop/1]).


start() -> 
  application:start(erlrrd).

start(_Type, _Args) -> 
  case application:get_env(erlrrd, extprog) of
    { ok, ExtProg } -> 
      erlrrd_sup:start_link(erlrrd, ExtProg);
    undefined -> 
      erlrrd_sup:start_link(erlrrd, "rrdtool -")
  end.

stop() -> 
  application:stop(erlrrd).

stop(_State) -> 
  ok. 
