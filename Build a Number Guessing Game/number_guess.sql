--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    number_of_guesses integer NOT NULL,
    secret_number integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 10, 539, 1);
INSERT INTO public.games VALUES (2, 36, 385, 1);
INSERT INTO public.games VALUES (3, 7, 782, 1);
INSERT INTO public.games VALUES (4, 19, 394, 2);
INSERT INTO public.games VALUES (5, 22, 935, 2);
INSERT INTO public.games VALUES (6, 10, 772, 3);
INSERT INTO public.games VALUES (7, 99, 98, 8);
INSERT INTO public.games VALUES (8, 235, 234, 8);
INSERT INTO public.games VALUES (9, 910, 909, 9);
INSERT INTO public.games VALUES (10, 640, 639, 9);
INSERT INTO public.games VALUES (11, 918, 915, 8);
INSERT INTO public.games VALUES (12, 46, 45, 8);
INSERT INTO public.games VALUES (13, 146, 145, 8);
INSERT INTO public.games VALUES (14, 887, 886, 10);
INSERT INTO public.games VALUES (15, 896, 895, 10);
INSERT INTO public.games VALUES (16, 802, 801, 11);
INSERT INTO public.games VALUES (17, 31, 30, 11);
INSERT INTO public.games VALUES (18, 889, 886, 10);
INSERT INTO public.games VALUES (19, 157, 156, 10);
INSERT INTO public.games VALUES (20, 18, 17, 10);
INSERT INTO public.games VALUES (21, 314, 313, 12);
INSERT INTO public.games VALUES (22, 876, 875, 12);
INSERT INTO public.games VALUES (23, 234, 233, 13);
INSERT INTO public.games VALUES (24, 794, 793, 13);
INSERT INTO public.games VALUES (25, 942, 939, 12);
INSERT INTO public.games VALUES (26, 300, 298, 12);
INSERT INTO public.games VALUES (27, 979, 978, 12);
INSERT INTO public.games VALUES (28, 710, 709, 14);
INSERT INTO public.games VALUES (29, 210, 209, 14);
INSERT INTO public.games VALUES (30, 433, 432, 15);
INSERT INTO public.games VALUES (31, 828, 827, 15);
INSERT INTO public.games VALUES (32, 930, 927, 14);
INSERT INTO public.games VALUES (33, 275, 273, 14);
INSERT INTO public.games VALUES (34, 923, 922, 14);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'Stephane');
INSERT INTO public.users VALUES (2, 'Roberto');
INSERT INTO public.users VALUES (3, 'Baja');
INSERT INTO public.users VALUES (4, 'user_1718665514542');
INSERT INTO public.users VALUES (5, 'user_1718665514541');
INSERT INTO public.users VALUES (6, 'user_1718667724235');
INSERT INTO public.users VALUES (7, 'user_1718667724234');
INSERT INTO public.users VALUES (8, 'user_1718668177878');
INSERT INTO public.users VALUES (9, 'user_1718668177877');
INSERT INTO public.users VALUES (10, 'user_1718668214869');
INSERT INTO public.users VALUES (11, 'user_1718668214868');
INSERT INTO public.users VALUES (12, 'user_1718668333392');
INSERT INTO public.users VALUES (13, 'user_1718668333391');
INSERT INTO public.users VALUES (14, 'user_1718668412749');
INSERT INTO public.users VALUES (15, 'user_1718668412748');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 34, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 15, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

