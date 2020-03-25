function question10()
  tools = few256;
  house = godthem256;
  phone = phonecalc256;

  figure(3)
  [height width] = size(tools);
  nrho = ceil(norm([height, width]));
  houghedgeline(tools, 4, 0, nrho, 180, 30, false);
  title('Without grey level voting.')

  figure(4)
  [height width] = size(tools);
  nrho = ceil(norm([height, width]));
  houghedgeline(tools, 4, 0, nrho, 180, 30, true);
  title('With grey level voting.')

  figure(5)
  [height width] = size(phone);
  nrho = ceil(norm([height, width]));
  houghedgeline(phone, 16, 0, nrho, 180, 30, false);
  title('Without grey level voting.')

  figure(6)
  [height width] = size(phone);
  nrho = ceil(norm([height, width]));
  houghedgeline(phone, 16, 0, nrho, 180, 30, true);
  title('With grey level voting.')

  figure(7)
  [height width] = size(house);
  nrho = ceil(norm([height, width]));
  houghedgeline(house, 4, 0, nrho, 180, 30, false);
  title('Without grey level voting.')

  figure(8)
  [height width] = size(house);
  nrho = ceil(norm([height, width]));
  houghedgeline(house, 4, 0, nrho, 180, 30, true);
  title('With grey level voting.')
end
