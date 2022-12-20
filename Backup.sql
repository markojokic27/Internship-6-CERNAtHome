PGDMP                         z            Internship-6-CERNAtHome    15.1    15.1 H    W           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            X           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            Y           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            Z           1262    41421    Internship-6-CERNAtHome    DATABASE     �   CREATE DATABASE "Internship-6-CERNAtHome" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Croatian_Croatia.1250';
 )   DROP DATABASE "Internship-6-CERNAtHome";
                postgres    false            �            1255    41603    checkhotel(integer)    FUNCTION     +  CREATE FUNCTION public.checkhotel(hotelid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE CapacityA INT;
BEGIN
SELECT SUM(HotelId) INTO CapacityA FROM Scientists;
IF CapacityA > (SELECT Capacity FROM Hotels WHERE Id = hotel_id) 
THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;
END;
$$;
 2   DROP FUNCTION public.checkhotel(hotelid integer);
       public          postgres    false            �            1259    41423    accelerators    TABLE     r   CREATE TABLE public.accelerators (
    acceleratorid integer NOT NULL,
    name character varying(30) NOT NULL
);
     DROP TABLE public.accelerators;
       public         heap    postgres    false            �            1259    41422    accelerators_acceleratorid_seq    SEQUENCE     �   CREATE SEQUENCE public.accelerators_acceleratorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.accelerators_acceleratorid_seq;
       public          postgres    false    215            [           0    0    accelerators_acceleratorid_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.accelerators_acceleratorid_seq OWNED BY public.accelerators.acceleratorid;
          public          postgres    false    214            �            1259    41543    cities    TABLE     e   CREATE TABLE public.cities (
    cityid integer NOT NULL,
    name character varying(30) NOT NULL
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    41542    cities_cityid_seq    SEQUENCE     �   CREATE SEQUENCE public.cities_cityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cities_cityid_seq;
       public          postgres    false    224            \           0    0    cities_cityid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.cities_cityid_seq OWNED BY public.cities.cityid;
          public          postgres    false    223            �            1259    41534 	   countries    TABLE     �   CREATE TABLE public.countries (
    countryid integer NOT NULL,
    name character varying(30) NOT NULL,
    population integer NOT NULL,
    ppp double precision NOT NULL
);
    DROP TABLE public.countries;
       public         heap    postgres    false            �            1259    41533    countries_countryid_seq    SEQUENCE     �   CREATE SEQUENCE public.countries_countryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.countries_countryid_seq;
       public          postgres    false    222            ]           0    0    countries_countryid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.countries_countryid_seq OWNED BY public.countries.countryid;
          public          postgres    false    221            �            1259    41552    hotels    TABLE     �   CREATE TABLE public.hotels (
    hotelid integer NOT NULL,
    name character varying(30) NOT NULL,
    cityid integer NOT NULL,
    capacity integer NOT NULL
);
    DROP TABLE public.hotels;
       public         heap    postgres    false            �            1259    41551    hotels_hotelid_seq    SEQUENCE     �   CREATE SEQUENCE public.hotels_hotelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hotels_hotelid_seq;
       public          postgres    false    226            ^           0    0    hotels_hotelid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.hotels_hotelid_seq OWNED BY public.hotels.hotelid;
          public          postgres    false    225            �            1259    41432    projects    TABLE     j   CREATE TABLE public.projects (
    projectid integer NOT NULL,
    name character varying(30) NOT NULL
);
    DROP TABLE public.projects;
       public         heap    postgres    false            �            1259    41431    projects_projectid_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_projectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.projects_projectid_seq;
       public          postgres    false    217            _           0    0    projects_projectid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.projects_projectid_seq OWNED BY public.projects.projectid;
          public          postgres    false    216            �            1259    41440    projectsaccelerators    TABLE     q   CREATE TABLE public.projectsaccelerators (
    acceleratorid integer NOT NULL,
    projectid integer NOT NULL
);
 (   DROP TABLE public.projectsaccelerators;
       public         heap    postgres    false            �            1259    41522    scientificworks    TABLE     �   CREATE TABLE public.scientificworks (
    workid integer NOT NULL,
    name character varying(30) NOT NULL,
    projectid integer NOT NULL,
    citationsnumber integer NOT NULL,
    created timestamp without time zone NOT NULL
);
 #   DROP TABLE public.scientificworks;
       public         heap    postgres    false            �            1259    41521    scientificworks_workid_seq    SEQUENCE     �   CREATE SEQUENCE public.scientificworks_workid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.scientificworks_workid_seq;
       public          postgres    false    220            `           0    0    scientificworks_workid_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.scientificworks_workid_seq OWNED BY public.scientificworks.workid;
          public          postgres    false    219            �            1259    41564 
   scientists    TABLE       CREATE TABLE public.scientists (
    scientistid integer NOT NULL,
    name character varying(30) NOT NULL,
    surname character varying(30) NOT NULL,
    birth timestamp without time zone NOT NULL,
    countryid integer NOT NULL,
    gender character varying(30),
    profession character varying(30),
    hotelid integer,
    CONSTRAINT scientists_gender_check CHECK (((gender)::text = ANY ((ARRAY['MUŠKI'::character varying, 'ŽENSKI'::character varying, 'NEPOZNATO'::character varying, 'OSTALO'::character varying])::text[]))),
    CONSTRAINT scientists_profession_check CHECK (((profession)::text = ANY ((ARRAY['programer'::character varying, 'fizičar'::character varying, 'inženjer'::character varying, 'znanstvenik materijala'::character varying])::text[])))
);
    DROP TABLE public.scientists;
       public         heap    postgres    false            �            1259    41563    scientists_scientistid_seq    SEQUENCE     �   CREATE SEQUENCE public.scientists_scientistid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.scientists_scientistid_seq;
       public          postgres    false    228            a           0    0    scientists_scientistid_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.scientists_scientistid_seq OWNED BY public.scientists.scientistid;
          public          postgres    false    227            �            1259    41582    worksscientists    TABLE     g   CREATE TABLE public.worksscientists (
    workid integer NOT NULL,
    scientistid integer NOT NULL
);
 #   DROP TABLE public.worksscientists;
       public         heap    postgres    false            �           2604    41426    accelerators acceleratorid    DEFAULT     �   ALTER TABLE ONLY public.accelerators ALTER COLUMN acceleratorid SET DEFAULT nextval('public.accelerators_acceleratorid_seq'::regclass);
 I   ALTER TABLE public.accelerators ALTER COLUMN acceleratorid DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    41546    cities cityid    DEFAULT     n   ALTER TABLE ONLY public.cities ALTER COLUMN cityid SET DEFAULT nextval('public.cities_cityid_seq'::regclass);
 <   ALTER TABLE public.cities ALTER COLUMN cityid DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    41537    countries countryid    DEFAULT     z   ALTER TABLE ONLY public.countries ALTER COLUMN countryid SET DEFAULT nextval('public.countries_countryid_seq'::regclass);
 B   ALTER TABLE public.countries ALTER COLUMN countryid DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    41555    hotels hotelid    DEFAULT     p   ALTER TABLE ONLY public.hotels ALTER COLUMN hotelid SET DEFAULT nextval('public.hotels_hotelid_seq'::regclass);
 =   ALTER TABLE public.hotels ALTER COLUMN hotelid DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    41435    projects projectid    DEFAULT     x   ALTER TABLE ONLY public.projects ALTER COLUMN projectid SET DEFAULT nextval('public.projects_projectid_seq'::regclass);
 A   ALTER TABLE public.projects ALTER COLUMN projectid DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    41525    scientificworks workid    DEFAULT     �   ALTER TABLE ONLY public.scientificworks ALTER COLUMN workid SET DEFAULT nextval('public.scientificworks_workid_seq'::regclass);
 E   ALTER TABLE public.scientificworks ALTER COLUMN workid DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    41567    scientists scientistid    DEFAULT     �   ALTER TABLE ONLY public.scientists ALTER COLUMN scientistid SET DEFAULT nextval('public.scientists_scientistid_seq'::regclass);
 E   ALTER TABLE public.scientists ALTER COLUMN scientistid DROP DEFAULT;
       public          postgres    false    228    227    228            F          0    41423    accelerators 
   TABLE DATA           ;   COPY public.accelerators (acceleratorid, name) FROM stdin;
    public          postgres    false    215   fX       O          0    41543    cities 
   TABLE DATA           .   COPY public.cities (cityid, name) FROM stdin;
    public          postgres    false    224   �X       M          0    41534 	   countries 
   TABLE DATA           E   COPY public.countries (countryid, name, population, ppp) FROM stdin;
    public          postgres    false    222   �X       Q          0    41552    hotels 
   TABLE DATA           A   COPY public.hotels (hotelid, name, cityid, capacity) FROM stdin;
    public          postgres    false    226   eY       H          0    41432    projects 
   TABLE DATA           3   COPY public.projects (projectid, name) FROM stdin;
    public          postgres    false    217   �Y       I          0    41440    projectsaccelerators 
   TABLE DATA           H   COPY public.projectsaccelerators (acceleratorid, projectid) FROM stdin;
    public          postgres    false    218   AZ       K          0    41522    scientificworks 
   TABLE DATA           \   COPY public.scientificworks (workid, name, projectid, citationsnumber, created) FROM stdin;
    public          postgres    false    220   {Z       S          0    41564 
   scientists 
   TABLE DATA           o   COPY public.scientists (scientistid, name, surname, birth, countryid, gender, profession, hotelid) FROM stdin;
    public          postgres    false    228   .[       T          0    41582    worksscientists 
   TABLE DATA           >   COPY public.worksscientists (workid, scientistid) FROM stdin;
    public          postgres    false    229   %\       b           0    0    accelerators_acceleratorid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.accelerators_acceleratorid_seq', 8, true);
          public          postgres    false    214            c           0    0    cities_cityid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cities_cityid_seq', 4, true);
          public          postgres    false    223            d           0    0    countries_countryid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.countries_countryid_seq', 6, true);
          public          postgres    false    221            e           0    0    hotels_hotelid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.hotels_hotelid_seq', 9, true);
          public          postgres    false    225            f           0    0    projects_projectid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.projects_projectid_seq', 4, true);
          public          postgres    false    216            g           0    0    scientificworks_workid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.scientificworks_workid_seq', 7, true);
          public          postgres    false    219            h           0    0    scientists_scientistid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.scientists_scientistid_seq', 8, true);
          public          postgres    false    227            �           2606    41430 "   accelerators accelerators_name_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.accelerators
    ADD CONSTRAINT accelerators_name_key UNIQUE (name);
 L   ALTER TABLE ONLY public.accelerators DROP CONSTRAINT accelerators_name_key;
       public            postgres    false    215            �           2606    41428    accelerators accelerators_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.accelerators
    ADD CONSTRAINT accelerators_pkey PRIMARY KEY (acceleratorid);
 H   ALTER TABLE ONLY public.accelerators DROP CONSTRAINT accelerators_pkey;
       public            postgres    false    215            �           2606    41550    cities cities_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_name_key;
       public            postgres    false    224            �           2606    41548    cities cities_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (cityid);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    224            �           2606    41541    countries countries_name_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_key UNIQUE (name);
 F   ALTER TABLE ONLY public.countries DROP CONSTRAINT countries_name_key;
       public            postgres    false    222            �           2606    41539    countries countries_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (countryid);
 B   ALTER TABLE ONLY public.countries DROP CONSTRAINT countries_pkey;
       public            postgres    false    222            �           2606    41557    hotels hotels_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (hotelid);
 <   ALTER TABLE ONLY public.hotels DROP CONSTRAINT hotels_pkey;
       public            postgres    false    226            �           2606    41439    projects projects_name_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_name_key UNIQUE (name);
 D   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_name_key;
       public            postgres    false    217            �           2606    41437    projects projects_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (projectid);
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public            postgres    false    217            �           2606    41444 .   projectsaccelerators projectsaccelerators_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.projectsaccelerators
    ADD CONSTRAINT projectsaccelerators_pkey PRIMARY KEY (projectid, acceleratorid);
 X   ALTER TABLE ONLY public.projectsaccelerators DROP CONSTRAINT projectsaccelerators_pkey;
       public            postgres    false    218    218            �           2606    41527 $   scientificworks scientificworks_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.scientificworks
    ADD CONSTRAINT scientificworks_pkey PRIMARY KEY (workid);
 N   ALTER TABLE ONLY public.scientificworks DROP CONSTRAINT scientificworks_pkey;
       public            postgres    false    220            �           2606    41571    scientists scientists_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.scientists
    ADD CONSTRAINT scientists_pkey PRIMARY KEY (scientistid);
 D   ALTER TABLE ONLY public.scientists DROP CONSTRAINT scientists_pkey;
       public            postgres    false    228            �           2606    41586 $   worksscientists worksscientists_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.worksscientists
    ADD CONSTRAINT worksscientists_pkey PRIMARY KEY (workid, scientistid);
 N   ALTER TABLE ONLY public.worksscientists DROP CONSTRAINT worksscientists_pkey;
       public            postgres    false    229    229            �           2606    41558    hotels hotels_cityid_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_cityid_fkey FOREIGN KEY (cityid) REFERENCES public.cities(cityid);
 C   ALTER TABLE ONLY public.hotels DROP CONSTRAINT hotels_cityid_fkey;
       public          postgres    false    3240    226    224            �           2606    41445 <   projectsaccelerators projectsaccelerators_acceleratorid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.projectsaccelerators
    ADD CONSTRAINT projectsaccelerators_acceleratorid_fkey FOREIGN KEY (acceleratorid) REFERENCES public.accelerators(acceleratorid);
 f   ALTER TABLE ONLY public.projectsaccelerators DROP CONSTRAINT projectsaccelerators_acceleratorid_fkey;
       public          postgres    false    215    218    3224            �           2606    41450 8   projectsaccelerators projectsaccelerators_projectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.projectsaccelerators
    ADD CONSTRAINT projectsaccelerators_projectid_fkey FOREIGN KEY (projectid) REFERENCES public.projects(projectid);
 b   ALTER TABLE ONLY public.projectsaccelerators DROP CONSTRAINT projectsaccelerators_projectid_fkey;
       public          postgres    false    218    3228    217            �           2606    41528 .   scientificworks scientificworks_projectid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.scientificworks
    ADD CONSTRAINT scientificworks_projectid_fkey FOREIGN KEY (projectid) REFERENCES public.projects(projectid);
 X   ALTER TABLE ONLY public.scientificworks DROP CONSTRAINT scientificworks_projectid_fkey;
       public          postgres    false    220    217    3228            �           2606    41572 $   scientists scientists_countryid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.scientists
    ADD CONSTRAINT scientists_countryid_fkey FOREIGN KEY (countryid) REFERENCES public.countries(countryid);
 N   ALTER TABLE ONLY public.scientists DROP CONSTRAINT scientists_countryid_fkey;
       public          postgres    false    228    222    3236            �           2606    41577 "   scientists scientists_hotelid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.scientists
    ADD CONSTRAINT scientists_hotelid_fkey FOREIGN KEY (hotelid) REFERENCES public.hotels(hotelid);
 L   ALTER TABLE ONLY public.scientists DROP CONSTRAINT scientists_hotelid_fkey;
       public          postgres    false    226    228    3242            �           2606    41592 0   worksscientists worksscientists_scientistid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worksscientists
    ADD CONSTRAINT worksscientists_scientistid_fkey FOREIGN KEY (scientistid) REFERENCES public.scientists(scientistid);
 Z   ALTER TABLE ONLY public.worksscientists DROP CONSTRAINT worksscientists_scientistid_fkey;
       public          postgres    false    3244    228    229            �           2606    41587 +   worksscientists worksscientists_workid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worksscientists
    ADD CONSTRAINT worksscientists_workid_fkey FOREIGN KEY (workid) REFERENCES public.scientificworks(workid);
 U   ALTER TABLE ONLY public.worksscientists DROP CONSTRAINT worksscientists_workid_fkey;
       public          postgres    false    220    229    3232            F   $   x�3����st�2��2���p�2��c���� [��      O   -   x�3�<�75/�,�ˈ�)�(�˘�)�85�˄383?�+F��� އ
W      M   ~   x�-̽�@��y�Kr�uDb ��,Q�P��J����j�K�w{���^)�ô�������:R���C+ʺ�v�Tsq��/d�gvU�d��8ĴRJ��4�6J��8�c�5*�7C�?��/:*!�      Q   �   x�-�=�0����)r���Q	*q ��T�*���>��:\�E����)	�%�=�'����yjpִL�P�Yj��E��4[����p����XS���!/�29%AS:�����������m��Y��;"��a.      H   5   x�3�(*�T((��J�.�2�t)*MG��9C�R�|N�Ԓ���H� 9`�      I   *   x�3�4�2�4bc 6�2�|# ��6�M�t� z�O      K   �   x�]�1�0Eg�\ �m�ޠw�J�JQ�J���7�!r�x{��)����0��j�B"0bo�-R�x=�aͿ�<	Ϥ��\������D2MX�Fӟc��^B�[l-q����)lq���|,᪽��c�O�D�6���N�Ӱ.)����QI��1���W1      S   �   x�u�MN�0����S�E���E]D�I��b3�u�8�$]�܁����	�!�j��	��#a3��ğ�hγ������6G�N��,<B�^bA�t�
gOe�ܔ��ؖx���R+-|9mU�����zߗE�n*3~H�8���5փ�n�eiz	��V��?.a	n��`%���K���!���Q�YK���!M�Y��*���u��$���O#`W��/�el      T   5   x���  ���0H�ð����HI�Zn�m�GAN(+5n�a3|�� �Nr     