# Linux command line

## Disk management

### du - disk usage

List size of all items in working directory


#### Important arguments

| arg | long | description |
|-- |-- |-- |
| -h | --human-readable | print sizes in human readable format (e.g., 1K 234M 2G) |
|-s | --summarize | display only a total for each argument |
| -c | --total | produce a grand total |
| -B | --block-size=SIZE | scale sizes by SIZE before printing them; e.g., '-BM' prints sizes in units of 1,048,576 bytes;  |

The SIZE argument is an integer and optional unit (example: 10K is 10*1024). Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).

#### Examples

List size of all items in working directory  
``` du -hsc * ```

List size of all directories in working directory  
``` du -hsc ./*/ ```

## File management

### tar

GNU 'tar' saves many files together into a single tape or disk archive, and can
restore individual files from the archive.

#### Important arguments

| arg | long | description |
|-- |-- |-- |
| -x | --extract | extract files from an archive |
| -z | --gzip | filter the archive through gzip |
| -t | --list | list the contents of an archive |
| -f | --file=ARCHIVE | use archive file or device ARCHIVE |
| -c | --create | create a new archive |
| -C | --directory=DIR | change to directory DIR |

#### Examples

Extract content from tar.gz archive  
``` tar -xzvf archive.tgz ```

Extract content from tar.gz archive to directory 'targetdir'  
``` tar --directory=./targetdir/ -xzvf archive.tgz ```

Create archive.tar from files foo and bar  
``` tar -cf archive.tar foo bar ```

Create compressed archive.tar from files foo and bar  
``` tar -cf archive.tar foo bar ```

